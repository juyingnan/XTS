/*
 *	SCCS: @(#)sigtrap.c	1.5 (98/09/01)
 *
 *	UniSoft Ltd., London, England
 *
 * (C) Copyright 1996 X/Open Company Limited
 *
 * All rights reserved.  No part of this source code may be reproduced,
 * stored in a retrieval system, or transmitted, in any form or by any
 * means, electronic, mechanical, photocopying, recording or otherwise,
 * except as stated in the end-user licence agreement, without the prior
 * permission of the copyright owners.
 * A copy of the end-user licence agreement is contained in the file
 * Licence which accompanies this distribution.
 * 
 * X/Open and the 'X' symbol are trademarks of X/Open Company Limited in
 * the UK and other countries.
 */

#ifndef lint
static char sccsid[] = "@(#)sigtrap.c	1.5 (98/09/01) TET3 release 3.3";
#endif

/************************************************************************

SCCS:   	@(#)sigtrap.c	1.5 98/09/01 TETware release 3.3
NAME:		sigtrap.c
PRODUCT:	TETware
AUTHOR:		Andrew Dingwall, UniSoft Ltd.
DATE CREATED:	September 1996

DESCRIPTION:
	tcc signal handling functions

MODIFICATIONS:
	Andrew Dingwall, UniSoft Ltd., May 1997
	corrected a bug in the WIN32 signal blocking emulation

	Andrew Dingwall, UniSoft Ltd., March 1998
	Arrange to interrupt looping directives on abort.


************************************************************************/

#include <stdio.h>
#include <sys/types.h>
#include <time.h>
#include <signal.h>
#include <errno.h>
#  include <unistd.h>
#include "dtmac.h"
#include "error.h"
#include "ltoa.h"
#include "scentab.h"
#include "proctab.h"
#include "tcc.h"
#include "tcclib.h"


#ifdef NEEDsrcFile
static char srcFile[] = __FILE__;	/* file name for error reporting */
#endif

/* signal dispositions on startup */
static void (*orig_sighup) PROTOLIST((int));
static void (*orig_sigquit) PROTOLIST((int));
static void (*orig_sigpipe) PROTOLIST((int));
static void (*orig_sigterm) PROTOLIST((int));

/* variables used by the WIN32 sigblock emulation */


/* static function declarations */
static int eng1_tcinterrupt PROTOLIST((struct proctab *));
static void engine_abort PROTOLIST((int));
static int engine_tcinterrupt PROTOLIST((int));
static void initial_sigtrap PROTOLIST((int));
static void (*install_handler PROTOLIST((int, void (*) PROTOLIST((int)))))
	PROTOLIST((int));
static int quick_killtc PROTOLIST((struct proctab *));
static void engine_sigterm PROTOLIST((int));
static void exec_sigprocmask PROTOLIST((int));
#  ifdef TET_LITE	/* -LITE-CUT-LINE */
static void tes2 PROTOLIST((int, void (*) PROTOLIST((int))));
#  endif /* TET_LITE */	/* -LITE-CUT-LINE */


/*
**	initsigtrap() - install initial signal traps
*/

void initsigtrap()
{
	orig_sighup = install_handler(SIGHUP, initial_sigtrap);
	orig_sigquit = install_handler(SIGQUIT, initial_sigtrap);
	orig_sigpipe = install_handler(SIGPIPE, initial_sigtrap);
	orig_sigterm = install_handler(SIGTERM, initial_sigtrap);
}

/*
**	initial_sigtrap() - signal handler for use before the execution
**		engine starts up
*/

static void initial_sigtrap(sig)
int sig;
{
	static char text[] = "TCC shutdown on signal";


	if (jnl_usable())
		(void) fprintf(stderr, "%s %d\n", text, sig);

	fatal(0, text, tet_i2a(sig));
}

/*
**	execsigtrap() - install signal traps for the execution engine
*/

void execsigtrap()
{
	exec_block_signals();
	(void) install_handler(SIGHUP, engine_sigterm);
	(void) install_handler(SIGQUIT, engine_abort);
	(void) install_handler(SIGPIPE, engine_sigterm);
	(void) install_handler(SIGTERM, engine_sigterm);
}

/*
**	exec_block_signals() - block signals while the execution engine
**		turns over
*/

void exec_block_signals()
{
	exec_sigprocmask(SIG_BLOCK);
}

void exec_unblock_signals()
{
	exec_sigprocmask(SIG_UNBLOCK);
}




/*
**	exec_sigprocmask() - block or unblock signals
*/

static void exec_sigprocmask(how)
int how;
{
	sigset_t mask;

	(void) sigemptyset(&mask);
	(void) sigaddset(&mask, SIGHUP);
	(void) sigaddset(&mask, SIGQUIT);
	(void) sigaddset(&mask, SIGPIPE);
	(void) sigaddset(&mask, SIGTERM);

	if (sigprocmask(how, &mask, (sigset_t *) 0) < 0)
		fatal(errno, "sigprocmask() failed: how =", tet_i2a(how));
}




/*
**	engine_sigterm() - SIGHUP and SIGTERM signal handler for use once
**		the execution engine is running
*/

static void engine_sigterm(sig)
int sig;
{
	TRACE2(TET_MAX(tet_Ttcc, tet_Texec), 4, "engine_sigterm(): signal = %s",
		tet_i2a(sig));

	initial_sigtrap(sig);
}



/*
**	engine_abort() - SIGQUIT (or SIGBREAK) signal handler for use once
**		the execution engine is running
*/

static void engine_abort(sig)
int sig;
{
	register struct proctab *prp;


	(void) fprintf(stderr, "TCC: user abort called\n");
	(void) fflush(stderr);

	/*
	** this flag tells the execution engine not to start processing
	** any more test cases
	*/
	tcc_modes |= TCC_ABORT;

	/* arrange to interrupt each directive on the run queue */
	for (prp = runq; prp; prp = prp->pr_rqforw)
		if (prp->pr_scen->sc_type == SC_DIRECTIVE)
			prp->pr_modes |= TCC_ABORT;

	/*
	** tell the execution engine to interrupt all the currently
	** running test cases; the combination of these two actions
	** causes tcc to exit normally as soon as any currently running
	** test cases have terminated and any save files and journal
	** processing has completed
	*/
	(void) engine_tcinterrupt(sig);

}

/*
**	engine_tcinterrupt() - tell the execution engine to interrupt all the
**		currently running test case(s)
**
**	return the number of test cases currently running
**
**	this function is called from a signal handler, which itself
**	should only be called while the execution engine is turning over
**
**	note that the test cases are not actually interrupted until
**	control returns to the execution engine
*/

#ifdef NOTRACE
/* ARGSUSED */
#endif
static int engine_tcinterrupt(sig)
int sig;
{
	register struct proctab *prp;
	register int count = 0;

	TRACE2(TET_MAX(tet_Ttcc, tet_Texec), 4,
		"engine_tcinterrupt(): signal = %s", tet_i2a(sig));

	/* arrange to interrupt each testcase on the run queue */
	for (prp = runq; prp; prp = prp->pr_rqforw)
		if (prp->pr_scen->sc_type == SC_TESTCASE) {
			prp->pr_modes |= TCC_ABORT;
			if (prp->pr_state == PRS_WAIT) {
				count++;
				(void) RUN_PROCTABS(prp, eng1_tcinterrupt);
				prp->pr_flags |= PRF_ATTENTION;
			}
		}

	return(count);
}

/*
**	eng1_tcinterrupt() - extend the engine_tcinterrupt() processing for a
**		testcase or tool running on a single system
**
**	always returns 0
*/

static int eng1_tcinterrupt(prp)
register struct proctab *prp;
{
	TRACE3(TET_MAX(tet_Ttcc, tet_Texec), 6,
		"eng1_tcinterrupt(%s): toolstate = %s",
		tet_i2x(prp), prtoolstate(prp->pr_toolstate));

	if (prp->pr_toolstate == PTS_RUNNING)
		prp->pr_toolstate = PTS_ABORT;

	return(0);
}

/*
**	engine_shutdown() - kill left-over test cases and remove lock
**		files when tcc is shutting down
**
**	this function is called during tcc's orderly shutdown processing;
**	control should not return to the execution engine after this
**	function has been called
**
**	when this function is called, there should only be left-over
**	test cases and lock files if the shutdown is being performed
**	under the control of a signal handler (eg: for SIGHUP or SIGTERM)
**
**	since control is not returned to the execution engine, any pending
**	save files and journal processing is not performed;
**	also, test cases are not waited for - if a test case does not
**	respond to SIGTERM, it is left running
**	(however, in fully-featured TETware, when tcc logs off each tccd,
**	tccd sends a SIGHUP to any left-over executed processes)
*/

void engine_shutdown()
{
	register struct proctab *prp;
	register int count = 0;
	static int been_here = 0;

	TRACE3(TET_MAX(tet_Ttcc, tet_Texec), 4,
		"engine_shutdown(): been_here = %s, runq = %s",
		tet_i2a(been_here), tet_i2x(runq));

	/* guard against multiple calls and recursive calls */
	if (been_here++) {
		TRACE1(TET_MAX(tet_Ttcc, tet_Texec), 4,
			"engine_shutdown() quick RETURN");
		return;
	}

	/* kill each running testcase or tool */
	for (prp = runq; prp; prp = prp->pr_rqforw)
		if (prp->pr_scen->sc_type == SC_TESTCASE) {
			count++;
			(void) RUN_PROCTABS(prp, quick_killtc);
		}

	/* give the tools a chance to terminate */
	if (count)
		SLEEP(2);

	/* remove lock files */
	for (prp = runq; prp; prp = prp->pr_rqforw)
		if (prp->pr_scen->sc_type == SC_TESTCASE)
			switch (prp->pr_currmode) {
			case TCC_BUILD:
			case TCC_EXEC:
			case TCC_CLEAN:
				prp->pr_tcstate = TCS_END;
				proc_testcase(prp);
				break;
			}

	TRACE1(TET_MAX(tet_Ttcc, tet_Texec), 4,
		"engine_shutdown() normal RETURN");
}

/*
**	quick_killtc() - kill a test case or tool quickly on a single system
**		without waiting for the tool to terminate or checking for
**		errors
**
**	always returns 0
*/

static int quick_killtc(prp)
struct proctab *prp;
{
	TRACE3(TET_MAX(tet_Ttcc, tet_Texec), 6,
		"quick_killtc(%s): toolstate = %s",
		tet_i2x(prp), prtoolstate(prp->pr_toolstate));

	if (prp->pr_toolstate == PTS_RUNNING) {
		(void) tcc_kill(*prp->pr_sys, prp->pr_remid, SIGTERM);
		prp->pr_toolstate = PTS_EXITED;
	}

	return(0);
}

/*
**	install_handler() - install a signal handler
*/

static void (*install_handler(sig, func))()
int sig;
void (*func) PROTOLIST((int));
{
	void (*rc) PROTOLIST((int));


	struct sigaction sa;

	if (sigaction(sig, (struct sigaction *) 0, &sa) < 0)
		fatal(errno, "can't get disposition for signal", tet_i2a(sig));

	if ((rc = sa.sa_handler) != SIG_IGN) {
		sa.sa_handler = func;
		sa.sa_flags = 0;
		(void) sigemptyset(&sa.sa_mask); 
		if (sigaction(sig, &sa, (struct sigaction *) 0) < 0)
			fatal(errno, "can't install handler for signal",
				tet_i2a(sig));
	}


	return(rc);
}


#  ifdef TET_LITE	/* -LITE-CUT-LINE- */

/*
**	tcc_exec_signals() - restore original signal dispositions
**		in the child process before an exec
**
**	this function is called from the tcclib function tcf_exec()
*/

void tcc_exec_signals()
{
	tes2(SIGHUP, orig_sighup);
	tes2(SIGQUIT, orig_sigquit);
	tes2(SIGPIPE, orig_sigpipe);
	tes2(SIGTERM, orig_sigterm);
}

/*
**	tes2() - extend the tcc_exec_signals() processing for a
**		single signal
*/
static void tes2(sig, func)
int sig;
void (*func) PROTOLIST((int));
{
	struct sigaction sa;

	/* ignore the signal */
	sa.sa_handler = SIG_IGN;
	sa.sa_flags = 0;
	(void) sigemptyset(&sa.sa_mask); 
	if (sigaction(sig, &sa, (struct sigaction *) 0) < 0)
		fatal(errno, "sigaction(SIG_IGN) failed for signal",
			tet_i2a(sig));

	/* unblock the signal */
	(void) sigemptyset(&sa.sa_mask);
	(void) sigaddset(&sa.sa_mask, sig);
	if (sigprocmask(SIG_UNBLOCK, &sa.sa_mask, (sigset_t *) 0) < 0)
		fatal(errno, "sigprocmask(SIG_UNBLOCK) failed for signal",
			tet_i2a(sig));

	/* restore the original signal disposition if not SIG_IGN */
	if (func != SIG_IGN) {
		sa.sa_handler = func;
		sa.sa_flags = 0;
		(void) sigemptyset(&sa.sa_mask); 
		if (sigaction(sig, &sa, (struct sigaction *) 0) < 0)
			fatal(errno, "sigaction() failed for signal",
				tet_i2a(sig));

	}
}

#  endif /* TET_LITE */	/* -LITE-CUT-LINE- */

