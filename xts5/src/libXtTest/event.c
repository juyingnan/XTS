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
* File: xts5/src/lib/libXtTest/event.c
*
* Description:
*	Event synchronization and management using Semaphores.
*
* Modifications:
* $Log: event.c,v $
* Revision 1.2  2005-11-03 08:42:02  jmichael
* clean up all vsw5 paths to use xts5 instead.
*
* Revision 1.1.1.2  2005/04/15 14:05:10  anderson
* Reimport of the base with the legal name in the copyright fixed.
*
* Revision 8.0  1998/12/23 23:25:39  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:43:53  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:17:58  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:14:30  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:45:18  tbr
* Branch point for Release 5.0.0
*
* Revision 3.2  1995/12/15  00:43:12  andy
* Prepare for GA Release
*
*/

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <XtTest.h>

#include <sys/ipc.h>
#include <sys/sem.h>

/*error messages formatted here*/
char ebuf[4096];
int s2;

#define	NUM_EVENTS	8

static	int		semid = -1;	/* semaphore key*/

#define	SEM_PERM	(S_IRWXU | S_IRWXG | S_IRWXO)

#ifdef OLDSIGNALS
static void     (*osig)();
#else
static struct   sigaction       nact;
#endif

/* Allocates Semaphores*/
int avs_alloc_sem()
{
	vsw_debug_enter("libXtTest/event.c:avs_alloc_sem()",0);

	if (semid != -1) {
		vsw_debug_exit("libXtTest/event.c:avs_alloc_sem()",0);
		return(0);
	}

	semid = semget(IPC_PRIVATE, NUM_EVENTS, IPC_CREAT | SEM_PERM);
	if (semid == -1) {
		trace("Allocating semaphores");
		sprintf(ebuf, "ERROR: semget failed, errno = %s", err_lookup(errno));
		tet_infoline(ebuf);
		tet_result(TET_UNRESOLVED);
		vsw_debug_exit("libXtTest/event.c:avs_alloc_sem()",0);
		return(-1);
	}

	vsw_debug_exit("libXtTest/event.c:avs_alloc_sem()",0);
	return(0);
}


void avs_free_sem()
{
	vsw_debug_enter("libXtTest/event.c:avs_free_sem()",0);

	if(semid != -1) {
		semctl(semid, 0, IPC_RMID, NULL);
		semid = -1;
	}

	vsw_debug_exit("libXtTest/event.c:avs_free_sem()",0);
}

/*
**	called with an event number in "event" and a time to wait 't'
**
**	if t is positive an alarm is set for time t to interrupt the semaphore
**	call which will block on the event being posted
**
**	if t is 0 we return immediately either 0 if the event
**	was there or -2 if it is not
**
**	if t is negative we'll block on the event forever
**
*/

int avs_wait_event(event, t)
int event;
int t;
{
	struct sembuf mysembuf;
	int save_errno;

	vsw_debug_enter("libXtTest/event.c:avs_wait_event()",0);

	if (semid == -1) {
		tet_infoline("ERROR: Semaphores used before initialization");
		tet_result(TET_UNRESOLVED);
		vsw_debug_exit("libXtTest/event.c:avs_wait_event()",0);
		return(-1);
	}

	if (event >= NUM_EVENTS) {
		sprintf(ebuf, "ERROR: avs_wait_event: event was: %d, expected less than %d", event, NUM_EVENTS);
		tet_infoline(ebuf);
		vsw_debug_exit("libXtTest/event.c:avs_wait_event()",0);
		return(-1);
	}

	mysembuf.sem_num = event;
	/*-1 means wait for it to go to 1 and then set it to 0*/
	mysembuf.sem_op = -1;
	/*block on it unless t said not to*/
	if (t != 0)
		mysembuf.sem_flg = 0;
	else
		mysembuf.sem_flg = IPC_NOWAIT;

	/*limit length of blocking if requested*/
	if (t > 0) {
		got_sigalrm = 0;
#if OLDSIGNALS
		osig = signal(SIGALRM, lsah);
#else
		sigemptyset(&(nact.sa_mask));
		nact.sa_handler = lsah;
		nact.sa_flags = 0;
		s2 = sigaction(SIGALRM,&nact,(struct sigaction *)NULL);
		if (s2 == -1) {
			uwerrno("sigaction");
			vsw_debug_exit("libXtTest/event.c:avs_wait_event()",0);
			return -1;
		}
#endif
		alarm((unsigned int)t);
	}

	s2 = semop(semid, &mysembuf, 1);

	/*protect errno from calls to stop alarm*/
	save_errno = errno;

	/*stop alarm*/
	if (t > 0) {
		unused_time = alarm(0);
#if OLDSIGNALS
        osig = signal(SIGALRM, osig);
#else
		sigemptyset(&(nact.sa_mask));
		nact.sa_handler = SIG_DFL;
		nact.sa_flags = 0;
		s2 = sigaction(SIGALRM,&nact,(struct sigaction *)NULL);
		if (s2 == -1) {
			uwerrno("sigaction");
			vsw_debug_exit("libXtTest/event.c:avs_wait_event()",0);
			return -1;
		}
#endif
		if (got_sigalrm != 0) {
			tet_infoline("ERROR: Timed out waiting for completion.");
			tet_result(TET_UNRESOLVED);
			vsw_debug_exit("libXtTest/event.c:avs_wait_event()",0);
			return -1;
		}
	}

	/*any fail is an error if we requested blocking*/
	if (mysembuf.sem_flg != IPC_NOWAIT) {
		if (s2 == -1) {
			sprintf(ebuf, "ERROR: avs_wait_event: semop failed, errno = %s", err_lookup(save_errno));
			tet_infoline(ebuf);
			tet_result(TET_UNRESOLVED);
			vsw_debug_exit("libXtTest/event.c:avs_wait_event()",0);
			return(-1);
		}
	}

	/*if we did not request blocking EAGAIN means we would have blocked*/
	/*treat this special*/
	else {
		if (s2 == -1) {
			if (save_errno == EAGAIN) {
				vsw_debug_exit("libXtTest/event.c:avs_wait_event()",0);
				return(-2);
			}
			else {
				sprintf(ebuf, "ERROR: avs_wait_event: semop failed, errno = %s", err_lookup(save_errno));
				tet_infoline(ebuf);
				tet_result(TET_UNRESOLVED);
				vsw_debug_exit("libXtTest/event.c:avs_wait_event()",0);
				return(-1);
			}
		}
	}
	vsw_debug_exit("libXtTest/event.c:avs_wait_event()",0);
	return 0;
}

int avs_post_event(event)
int event;
{
	struct sembuf mysembuf;

	vsw_debug_enter("libXtTest/event.c:avs_post_event()",0);

	if (semid == -1) {
		tet_infoline("ERROR: Semaphores used before initialization");
		tet_result(TET_UNRESOLVED);
		vsw_debug_exit("libXtTest/event.c:avs_post_event()",0);
		return(-1);
	}
	if (event >= NUM_EVENTS) {
		sprintf(ebuf, "ERROR: avs_post_event: event was: %d, expected less than %d", event, NUM_EVENTS);
		tet_infoline(ebuf);
		vsw_debug_exit("libXtTest/event.c:avs_post_event()",0);
		return(-1);
	}

	mysembuf.sem_num = event;
	/*positive means we're setting it, to 1*/
	mysembuf.sem_op = 1;
	mysembuf.sem_flg = 0;

	s2 = semop(semid, &mysembuf, 1);
	if (s2 == -1) {
		sprintf(ebuf, "ERROR: avs_post_event: semop failed, errno = %s", err_lookup(errno));
		tet_infoline(ebuf);
		tet_result(TET_UNRESOLVED);
		vsw_debug_exit("libXtTest/event.c:avs_post_event()",0);
		return(-1);
	}
	vsw_debug_exit("libXtTest/event.c:avs_post_event()",0);
	return 0;
}

int avs_set_event(event, val)
int event;
int val;
{
	union semun {
		int val;
		struct semid_ds *buf;
		unsigned short *array;
	} arg;

	vsw_debug_enter("libXtTest/event.c:avs_set_event()",0);

	if (semid == -1) {
		tet_infoline("ERROR: Semaphores used before initialization");
		tet_result(TET_UNRESOLVED);
		vsw_debug_exit("libXtTest/event.c:avs_set_event()",0);
		return(-1);
	}
	if (event >= NUM_EVENTS) {
		sprintf(ebuf, "ERROR: avs_set_event: event was: %d, expected less than %d", event, NUM_EVENTS);
		tet_infoline(ebuf);
		vsw_debug_exit("libXtTest/event.c:avs_set_event()",0);
		return(-1);
	}

	/*cram it in there*/
	arg.val = val;
	s2 = semctl(semid, event, SETVAL, arg);
	if (s2 == -1) {
		sprintf(ebuf, "ERROR: avs_set_event: semctl failed, errno = %s", err_lookup(errno));
		tet_infoline(ebuf);
		tet_result(TET_UNRESOLVED);
		vsw_debug_exit("libXtTest/event.c:avs_set_event()",0);
		return(-1);
	}
	vsw_debug_exit("libXtTest/event.c:avs_set_event()",0);
	return 0;
}


int avs_get_event(event)
int event;
{
	vsw_debug_enter("libXtTest/event.c:avs_get_event()",0);

	if (semid == -1) {
		tet_infoline("ERROR: Semaphores used before initialization");
		tet_result(TET_UNRESOLVED);
		vsw_debug_exit("libXtTest/event.c:avs_get_event()",0);
		return(-1);
	}
	if (event >= NUM_EVENTS) {
		sprintf(ebuf, "ERROR: avs_get_event: event was: %d, expected less than %d", event, NUM_EVENTS);
		tet_infoline(ebuf);
		vsw_debug_exit("libXtTest/event.c:avs_get_event()",0);
		return(-1);
	}

	/*read it out*/
	s2 = semctl(semid, event, GETVAL, NULL);
	if (s2 == -1) {
		sprintf(ebuf, "ERROR: avs_set_event: semctl failed, errno = %s", err_lookup(errno));
		tet_infoline(ebuf);
		tet_result(TET_UNRESOLVED);
		vsw_debug_exit("libXtTest/event.c:avs_get_event()",0);
		return(-1);
	}
	vsw_debug_exit("libXtTest/event.c:avs_get_event()",0);
	return (s2);
}
