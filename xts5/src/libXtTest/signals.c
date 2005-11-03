/*
Copyright (c) 2005 X.Org Foundation L.L.C.

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/
/*
* $Header: /cvs/xtest/xtest/xts5/src/libXtTest/signals.c,v 1.2 2005-11-03 08:42:02 jmichael Exp $
*
* Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
* Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
* All Rights Reserved.
*
* Project: VSW5
*
* File: xts5/src/lib/libXtTest/signals.c
*
* Description:
*	Routines to manipulate signals.
*
* Modifications:
* $Log: signals.c,v $
* Revision 1.2  2005-11-03 08:42:02  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:10  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:25:42  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:43:56  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:18:00  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:14:32  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:45:26  tbr
* Branch point for Release 5.0.0
*
* Revision 3.2  1995/12/15  00:43:22  andy
* Prepare for GA Release
*
*/


#include <tet_api.h>
#include <sys/types.h>
#include <unistd.h>
#include <signal.h>
#include <errno.h>

void    uwerrno();
void    vsw_debug_enter();
void    vsw_debug_exit();

int              got_sigalrm;
unsigned         unused_time;


extern char		ebuf[4096];
extern int		s2;

#ifdef OLDSIGNALS
static void     (*osig)();
#else
static struct   sigaction       nact;
#endif

void lsah(sig)
int sig;
{
	got_sigalrm++;
}


int avs_signal(sig, handler)
int sig;
void (*handler)(int);
{
	vsw_debug_enter("libXtTest/signals.c:avs_signal()",0);

#if OLDSIGNALS
	osig = signal(sig, handler);
#else
        s2 = sigemptyset(&(nact.sa_mask));
	if (s2 == -1) {
		uwerrno("sigemptyset");
		vsw_debug_exit("libXtTest/signals.c:avs_signal()",0);
		return -1;
	}
        nact.sa_handler = handler;
        nact.sa_flags = 0;
        s2 = sigaction(sig,&nact,(struct sigaction *)NULL);
	if (s2 == -1) {
		uwerrno("sigaction");
		vsw_debug_exit("libXtTest/signals.c:avs_signal()",0);
		return -1;
	}
#endif
	vsw_debug_exit("libXtTest/signals.c:avs_signal()",0);
	return 0;
}


int avs_set_alarm(my_time)
int my_time;
{
	vsw_debug_enter("libXtTest/signals.c:avs_set_alarm()",0);

	got_sigalrm = 0;
        if(avs_signal(SIGALRM, lsah) == -1) {
		vsw_debug_exit("libXtTest/signals.c:avs_set_alarm()",0);
		return -1;
	}
	vsw_debug_exit("libXtTest/signals.c:avs_set_alarm()",0);
	return alarm((unsigned int)my_time);
}


int avs_clear_alarm()
{
	vsw_debug_enter("libXtTest/signals.c:avs_clear_alarm()",0);

	unused_time = alarm(0);
	if(avs_signal(SIGALRM, SIG_DFL) == -1) {
		vsw_debug_exit("libXtTest/signals.c:avs_clear_alarm()",0);
		return -1;
	}
	
	if (got_sigalrm != 0) {
		tet_infoline("ERROR: Timed out waiting for completion.");
		tet_result(TET_UNRESOLVED);
		vsw_debug_exit("libXtTest/signals.c:avs_clear_alarm()",0);
		return(-1);
	} 
	vsw_debug_exit("libXtTest/signals.c:avs_clear_alarm()",0);
	return 0;
}


int avs_expect_alarm()
{
	vsw_debug_enter("libXtTest/signals.c:avs_expect_alarm()",0);

	unused_time = alarm(0);
	if(avs_signal(SIGALRM,SIG_DFL) == -1) {
		vsw_debug_exit("libXtTest/signals.c:avs_expect_alarm()",0);
		return -1;
	}
	if (got_sigalrm == 0) {
		tet_infoline("ERROR: Did not time out.");
		tet_result(TET_UNRESOLVED);
		vsw_debug_exit("libXtTest/signals.c:avs_expect_alarm()",0);
		return -1;
	} 
	vsw_debug_exit("libXtTest/signals.c:avs_expect_alarm()",0);
	return 0;
}


int avs_ignore_alarm()
{
	vsw_debug_enter("libXtTest/signals.c:avs_ignore_alarm()",0);

	unused_time = alarm(0);
	vsw_debug_exit("libXtTest/signals.c:avs_ignore_alarm()",0);
	return avs_signal(SIGALRM,SIG_DFL);                
}
