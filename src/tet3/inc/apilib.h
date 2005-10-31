/*
 *	SCCS: @(#)apilib.h	1.2 (98/08/28)
 *
 *	UniSoft Ltd., London, England
 *
 * (C) Copyright 1997 X/Open Company Limited
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

/************************************************************************

SCCS:   	@(#)apilib.h	1.2 98/08/28 TETware release 3.3
NAME:		apilib.h
PRODUCT:	TETware
AUTHOR:		Andrew Dingwall, UniSoft Ltd.
DATE CREATED:	June 1997

DESCRIPTION:
	declarations of extern functions and data items,
	not declared in other header files,
	which are used in the TCM and API

	since one of the function prototypes includes a pid_t,
	this file must be included after tet_api.h if tet_api.h is included

MODIFICATIONS:
	Andrew Dingwall, UniSoft Ltd., August 1998
	Added support for shared libraries.

************************************************************************/

/*
** the interface between tet_exec()/tet_spawn()/tet_remexec()
** and the child process controllers
**
** when a child (or remote) process is called using tet_foo(... file, argv ...)
** the arguments passed to exec()/spawn() are:
**
**	newargv[0]	file
**	newargv[1]	tet_thistest
**	newargv[2]	tet_activity
**	newargv[3]	tet_context
**	newargv[4]	tet_block or tet_next_block
**	newargv[5]	argv[0]
**	...		...
*/
#define TET_TCMC_THISTEST	1
#define TET_TCMC_ACTIVITY	2
#define TET_TCMC_CONTEXT	3
#define TET_TCMC_BLOCK		4
#define TET_TCMC_USER_ARGS	5	/* must have the highest value */


/*
**	extern data items
*/

TET_IMPORT_DATA(long, tet_activity);	/* TCC activity number */
TET_IMPORT_DATA(int, tet_combined_ok);	/* true if xres file is usable */
TET_IMPORT_DATA(long, tet_context);	/* journal context number */
TET_IMPORT_ARRAY(char *, tet_apilib_version, []);
					/* the API library version strings */

#ifdef TET_THREADS
   TET_IMPORT_FUNC(long *, tet_thr_block, PROTOLIST((void)));
#  define tet_block	(*tet_thr_block())
   TET_IMPORT_FUNC(long *, tet_thr_sequence, PROTOLIST((void)));
#  define tet_sequence	(*tet_thr_sequence())
   TET_IMPORT_DATA(long, tet_next_block);
#else
   TET_IMPORT_DATA(long, tet_block);	/* journal block number */
   TET_IMPORT_DATA(long, tet_sequence);	/* journal sequence number */
#endif

#ifdef TET_LITE	/* -LITE-CUT-LINE- */
   TET_IMPORT_DATA(char *, tet_tmpresfile);
					/* temporary results file name */
   extern FILE *tet_tmpresfp;		/* fp for temporary results file */
   extern FILE *tet_resfp;		/* fp for tet_xres file */
#else		/* -START-LITE-CUT- */
   TET_IMPORT_DATA(int, tet_iclast);	/* highest defined IC number */
   TET_IMPORT_DATA(int, tet_sync_del);	/* true if TP deleted in another TCM */
   TET_EXPORT_DATA(int *, tet_snames);	/* system name list */
   TET_EXPORT_DATA(int, tet_Nsname);	/* number of system names */
   TET_EXPORT_DATA(long, tet_snid);	/* sync ID for this test case */
   TET_EXPORT_DATA(long, tet_xrid);	/* xres ID for this test case */
#endif		/* -END-LITE-CUT- */


/*
**	extern function declarations
*/

TET_IMPORT_FUNC(void, tet_config, PROTOLIST((void)));
extern void tet_docleanup PROTOLIST((int));
TET_IMPORT_FUNC(void, tet_error, PROTOLIST((int, char *)));
extern void tet_exec_cleanup PROTOLIST((char **, char **, char **));
extern int tet_exec_prep PROTOLIST((char *, char *[], char *[], char ***,
	char ***));
TET_IMPORT_FUNC(void, tet_icend, PROTOLIST((int, int)));
TET_IMPORT_FUNC(int, tet_icstart, PROTOLIST((int, int)));
#ifdef TET_PID_T_DEFINED
   TET_IMPORT_FUNC(int, tet_killw, PROTOLIST((pid_t, unsigned int)));
#endif
extern void tet_merror PROTOLIST((int, char **, int));
extern void tet_msgform PROTOLIST((char *, char *, char *));
extern void tet_routput PROTOLIST((char **, int));
TET_IMPORT_FUNC(char *, tet_signame, PROTOLIST((int)));
TET_IMPORT_FUNC(void, tet_tcmstart, PROTOLIST((char *, int)));
TET_IMPORT_FUNC(int, tet_tpend, PROTOLIST((int, int, int)));
TET_IMPORT_FUNC(void, tet_tpstart, PROTOLIST((int, int, int)));

#ifdef TET_LITE /* -LITE-CUT-LINE- */
   extern char *tet_get_code PROTOLIST((int, int *));
   TET_IMPORT_FUNC(void, tet_openres, PROTOLIST((void)));
#else		/* -START-LITE-CUT- */
   extern void tet_disconnect PROTOLIST((void));
   TET_IMPORT_FUNC(void, tet_init_synreq, PROTOLIST((void)));
#endif		/* -END-LITE-CUT- */

#ifdef TET_THREADS
  TET_IMPORT_FUNC(void, tet_cln_threads, PROTOLIST((int)));
  TET_IMPORT_FUNC(void, tet_mtx_destroy, PROTOLIST((void)));
  TET_IMPORT_FUNC(void, tet_mtx_init, PROTOLIST((void)));
#endif


