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
*
* Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
* Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
* All Rights Reserved.
*
* Project: VSW5
*
* File: xts5/include/XtTest.h
*
* Description:
*	Defines used by the Xt tests
*
* Modifications:
* $Log: XtTest.h,v $
* Revision 1.2  2005-11-03 08:42:00  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:07  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:23:30  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:41:35  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:16:01  tbr
* Branch point for Release 5.0.1
*
* Revision 5.1  1998/02/24 02:04:17  andy
* Added support for XT_COVERAGE exec config variable.
*
* Revision 5.0  1998/01/26 03:12:32  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.1  1998/01/12 23:00:24  andy
* Corrected testing for ANSI mode
*
* Revision 4.0  1995/12/15 08:38:30  tbr
* Branch point for Release 5.0.0
*
* Revision 3.2  1995/12/15  00:37:59  andy
* Prepare for GA Release
*
*/

#ifndef XTESTS_H
#define XTESTS_H

#include <sys/types.h>
#include <limits.h>
#include <errno.h>
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <signal.h>
#include <string.h>

/* 
 * Define NULL if not already done - really just SunOS writearound.
 * NULL should be in stdlib.h - but SunOS4.1 does not have it.
 */
#ifndef	NULL
#define NULL	0
#endif
/*
 * Invocable component types
 */
#define	Good	1
#define Bad 	2

#include <tet_api.h>

/* Toolkit definitions */
#include <X11/Intrinsic.h>
#include <X11/StringDefs.h>
#include <X11/Shell.h>

#include "XtTestProto.h"
#include "xtestlib.h"

/*
 * Options are all set into this structure.
 */
struct	config	{
	int	coverage;		/* Coverage Level */
	char	*display;		/* The display string */
	int	manual;			/* Run Xt Manual tests?*/
	int 	alt_screen;		/* Alternate screen number */
	int 	fontcursor_good;	/* A good value in the cursor font */
	int 	fontcursor_bad;		/* A bad value in the cursor font */
	char	*fontdir;		/* Font location for pixel generation */
	char	*fontpath_good;		/* known good path for fonts */
	char	*fontpath_bad;		/* known bad path for fonts */
	char	*bad_font_name;		/* known bad font name */
	int 	save_server_image;	/* Save server images */
	char	*good_colorname;	/* known good name */
	char	*bad_colorname;		/* known bad name */
	int 	option_no_check;	/* No check messages in the journal */
	int 	option_no_trace;	/* No trace messages in the journal */
	int 	debug;			/* debug level */
	int 	debug_override_redirect;/* Use override redirect on windows */
	int 	debug_pause_after;	/* pause after each XCALL */
	int 	debug_pixmap_only;	/* use only pixmaps */
	int 	debug_window_only;	/* use only windows */
	int 	debug_default_depths;	/* use default depth/visual */
	int	speedfactor;		/* used as multiplier when timing */
	int	displaymotionbuffersize;/* value to be returned by ... */
	char	*fontpath;		/* font path for test fonts */
	int	posix_system;		/* whether posix system */
	int	protocol_version;	/* protocol version */
	int	protocol_revision;	/* protocol revision */
	int	vendor_release;		/* vendor release */
	int	does_save_unders;	/* save unders supported */
	int	does_backing_store;	/* backing store supported */
	int	decnet;			/* decnet supported */
	int	tcp;			/* tcp supported */
	char	*displayhost;		/* hostname for XOpenDisplay tests */ 
	char 	*debug_byte_sex;	/* byte sex for X protocol tests */
	int 	debug_visual_check;	/* time delay in X protocol tests */
	int	local;			/* local display server supported */
	int	screen_count;		/* Number of screen server supports */
	char	*visual_classes;	/* The visual class/depth pairs */
	char	*debug_no_pixcheck;	/* Disable pixchecking */
	char	*pixmap_depths;		/* List of pixmap formats */
	char	*server_vendor;		/* returned by XServerVendor */
	int	black_pixel;		/* returned by XBlackPixel */
	int	white_pixel;		/* returned by XWhitePixel */
	int	height_mm;		/* returned by XHeightMMOfScreen */
	int	width_mm;		/* returned by XWidthMMOfScreen */
	int	reset_delay;		/* delay to allow for server reset */
	char	*debug_visual_ids;	/* list of visuals to use */
	int 	extensions;		/* Do we want to use xtest extensions */
};

extern struct config config;

/*
 * Xim Configuration struct
 */
struct ximconfig {
	char *locale;           /* locales to test */
	char *locale_modifiers;    /* locale modifiers to test */
	char *fontsets;            /* font sets for XCreateFontSet */
	int	save_im;
};

extern struct ximconfig ximconfig;

/*timeout passed to waitpid to terminate child processes*/
/*expiration is always an error indicating something hung*/
/*expressed in seconds*/
#define AVSXTTIMEOUT	30

/*Value passed to Xt[App]AddTimeOut in those tests where a timeout*/
/*terminates an Xt[App]MainLoop*/
/*expressed in milliseconds*/
#define AVSXTLOOPTIMEOUT	3000

#define	STRLEN	512	/* length of strings */
#define	SEP	","

#define	MAX_TIME_TO_RUN	20
#define	WAIT_FOR_TIME	2
#define	PROT_ALL	((mode_t)(S_IRWXU|S_IRWXG|S_IRWXO))

extern int		got_sigalrm;
extern unsigned		unused_time;
extern struct sigaction	Sigaction;

/*
static void siga(s)
int s;
{
	got_sigalrm++;
}
*/


#define SIGNAL_RET(signal, handler) {			\
	if(avs_signal(signal, handler) == -1) {		\
		return -1;					\
	}						\
}

#define SET_ALARM(time)                                 \
	if(avs_set_alarm(time) == -1) {			\
		return;					\
	}						\


#define CLEAR_ALARM_WITH_ERROR				\
	if(avs_clear_alarm()) {				\
		return -1;				\
	}						\

#define CLEAR_ALARM                                     \
	if(avs_clear_alarm()) {				\
		return;					\
	}						\

#define EXPECT_ALARM                                    \
	if(avs_expect_alarm()) {				\
		return;					\
	}						\


#define IGNORE_ALARM                                    \
	if(avs_ignore_alarm()) {				\
		return;					\
	}						\


#define FORK(pid) \
	if ((pid = fork()) == 0) { \
			  tet_setcontext();

#define KROF(pid) \
		exit(0); \
	} \
	tet_setblock(); \
	wait_for(pid, MAX_TIME_TO_RUN);

#define LKROF(pid,wait_time) \
		exit(0); \
	} \
	tet_setblock(); \
	wait_for(pid, wait_time);

#define EFORK \
		exit(0); \
	} \
	tet_setblock(); \

#define KROF2(pid,status)\
		exit(0); \
	} \
	tet_setblock(); \
	status = wait_for(pid, MAX_TIME_TO_RUN);

#define KROF3(pid,status, wait_time)\
		exit(0); \
	} \
	tet_setblock(); \
	status = wait_for(pid, wait_time);

/*The current time */
#define NOW	time((time_t *)0)

/* BUSY_WAIT(sec) -- Do a busy wait for `sec' seconds */
#define BUSY_WAIT(sec) { \
	time_t t; \
	t = NOW + (time_t)sec; \
	while (NOW < t) \
		; \
}


#define BEGIN_EVENTS		if (avs_alloc_sem() == -1) \
					return;
#define END_EVENTS		(avs_free_sem())
#define WAIT_EVENT(x)		(avs_wait_event((x), MAX_TIME_TO_RUN))
#define WAIT_EVENT2(x)		(avs_wait_event((x), MAX_TIME_TO_RUN*2))
#define WAIT_EVENTN(x,t)	(avs_wait_event((x), t))
#define POST_EVENT(x)		(avs_post_event(x))
#define GET_EVENT(x)		(avs_get_event(x))
#define SET_EVENT(x,y)		(avs_set_event(x,y))

#define WAIT_FOR_PID(pid)	(wait_for(pid, MAX_TIME_TO_RUN))

#define PASS	tet_result(TET_PASS)
#define FAIL    do { fail++; if (!isdeleted()) tet_result(TET_FAIL); } while (0)
#define UNTESTED	tet_result(TET_UNTESTED)
#define UNSUPPORTED	tet_result(TET_UNSUPPORTED)
#define UNRESOLVED	tet_result(TET_UNRESOLVED)
#define NOTINUSE	tet_result(TET_NOTINUSE)
#define WARNING		tet_result(MIT_TET_WARNING)
#define FIP		tet_result(MIT_TET_FIP)
#define	ABORT		tet_result(MIT_TET_ABORT)
#define	CHECKPASS(n) \
do { \
	if (n && n == pass && fail == 0) \
		PASS; \
	else if (fail == 0) {\
		if (n == 0) \
			report("No CHECK marks encountered"); \
		else \
			report("Path check error (%d should be %d)", pass, n);\
		report("This is usually caused by a programming error in the test-suite"); \
		UNRESOLVED;\
	} \
} while (0)
#define	CHECKUNTESTED(n) \
do { \
	if (n && n == pass && fail == 0) \
		untested("The assertion can only be partially tested"); \
	else if (fail == 0) {\
		if (n == 0) \
			report("Path check error - no CHECK marks encountered"); \
		else \
			report("Path check error (%d should be %d)", pass, n);\
		report("This is usually caused by a programming error in the test-suite"); \
		UNRESOLVED;\
	} \
} while (0)
#define	CHECKFIP(n) \
do { \
	if (n && n == pass && fail == 0) \
		FIP; \
	else if (fail == 0) {\
		if (n == 0) \
			report("Path check error - no CHECK marks encountered"); \
		else \
			report("Path check error (%d should be %d)", pass, n);\
		report("This is usually caused by a programming error in the test-suite"); \
		UNRESOLVED;\
	} \
} while (0)

#endif /* XTTESTS_H */
