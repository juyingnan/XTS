/*
Copyright (c) 2005 X.Org Foundation LLC

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
* $Header: /cvs/xtest/xtest/xts5/src/libXtTest/errlook.c,v 1.1 2005-02-12 14:37:15 anderson Exp $
*
* Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
* Copyright (c) 88open Consortium, Ltd. 1990, 1991, 1992, 1993
* All Rights Reserved.
*
* Project: VSW5
*
* File: vsw5/src/lib/libXtTest/errlook.c
*
* Description:
*	This file contains code to print error messages for errno values
*
* Modifications:
* $Log: errlook.c,v $
* Revision 1.1  2005-02-12 14:37:15  anderson
* Initial revision
*
* Revision 8.0  1998/12/23 23:25:38  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:43:52  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:17:57  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:14:29  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:45:17  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:43:10  andy
* Prepare for GA Release
*
*/

#include <XtTest.h>
#include <errno.h>

struct	errz_t {
	int	err;
	char	*errname;
};

static struct errz_t errz[] = {
/*XPG4 errnos*/
#ifdef E2BIG
	{ E2BIG,		"E2BIG - Arg list too long"},
#endif
#ifdef EACCES
	{ EACCES,		"EACCES - Permission denied"},
#endif
#ifdef EAGAIN
	{ EAGAIN,		"EAGAIN - No more processes"},
#endif
#ifdef EBADF
	{ EBADF,		"EBADF - Bad file number"},
#endif
#ifdef EBUSY
	{ EBUSY,		"EBUSY - Device busy"},
#endif
#ifdef ECHILD
	{ ECHILD,		"ECHILD - No child processes"},
#endif
#ifdef EDEADLK
	{ EDEADLK,		"EDEADLK - Deadlock situation detected/avoided"},
#endif
#ifdef EDOM
	{ EDOM,			"EDOM - Argument out of domain"},
#endif
#ifdef EEXIST
	{ EEXIST,		"EEXIST - File exists"},
#endif
#ifdef EFAULT
	{ EFAULT,		"EFAULT - Bad address"},
#endif
#ifdef EFBIG
	{ EFBIG,		"EFBIG - File too large"},
#endif
#ifdef EIDRM
	{ EIDRM,		"EIDRM - Identifier removed"},
#endif
#ifdef EILSEQ
	{ EILSEQ,		"EILSEQ - Illegal Byte Sequence"},
#endif
#ifdef EINTR
	{ EINTR,		"EINTR - Interrupted system call"},
#endif
#ifdef EINVAL
	{ EINVAL,		"EINVAL - Invalid argument"},
#endif
#ifdef EIO
	{ EIO,			"EIO - I/O error"},
#endif
#ifdef EISDIR
	{ EISDIR,		"EISDIR - Is a directory"},
#endif
#ifdef EMFILE
	{ EMFILE,		"EMFILE - Too many open files"},
#endif
#ifdef EMLINK
	{ EMLINK,		"EMLINK - Too many links"},
#endif
#ifdef ENAMETOOLONG
	{ ENAMETOOLONG,		"ENAMETOOLONG - Filename too long"},
#endif
#ifdef ENFILE
	{ ENFILE,		"ENFILE - File table overflow"},
#endif
#ifdef ENODEV
	{ ENODEV,		"ENODEV - No such device"},
#endif
#ifdef ENOENT
	{ ENOENT,		"ENOENT - No such file or directory"},
#endif
#ifdef ENOEXEC
	{ ENOEXEC,		"ENOEXEC - Exec format error"},
#endif
#ifdef ENOLCK
	{ ENOLCK,		"ENOLCK - No record locks available"},
#endif
#ifdef ENOMEM
	{ ENOMEM,		"ENOMEM - Not enough space"},
#endif
#ifdef ENOMSG
	{ ENOMSG,		"ENOMSG - No message of desired type"},
#endif
#ifdef ENOSPC
	{ ENOSPC,		"ENOSPC - No space left on device"},
#endif
#ifdef ENOSYS
	{ ENOSYS,		"ENOSYS - System call not installed"},
#endif
#ifdef ENOTDIR
	{ ENOTDIR,		"ENOTDIR - Not a directory"},
#endif
#ifdef ENOTEMPTY
	{ ENOTEMPTY,		"ENOTEMPTY - Not empty"},
#endif
#ifdef ENOTTY
	{ ENOTTY,		"ENOTTY - Not a typewriter"},
#endif
#ifdef ENXIO
	{ ENXIO,		"ENXIO - No such device or address"},
#endif
#ifdef EPERM
	{ EPERM,		"EPERM - Not owner"},
#endif
#ifdef EPIPE
	{ EPIPE,		"EPIPE - Broken pipe"},
#endif
#ifdef ERANGE
	{ ERANGE,		"ERANGE - Result too large"},
#endif
#ifdef EROFS
	{ EROFS,		"EROFS - Read-only file system"},
#endif
#ifdef ESPIPE
	{ ESPIPE,		"ESPIPE - Illegal seek"},
#endif
#ifdef ESRCH
	{ ESRCH,		"ESRCH - No such process"},
#endif
#ifdef ETXTBSY
	{ ETXTBSY,		"ETXTBSY - Text file busy"},
#endif
#ifdef EXDEV
	{ EXDEV,		"EXDEV - Cross-device link"},
#endif

/*1170 errnos*/
#ifdef EADDRINUSE
	{ EADDRINUSE,		"EADDRINUSE - Address in use"},
#endif
#ifdef EADDRNOTAVAIL
	{ EADDRNOTAVAIL,	"EADDRNOTAVAIL - Address not available"},
#endif
#ifdef EAFNOSUPPORT
	{ EAFNOSUPPORT,		"EAFNOSUPPORT - Address family not supported"},
#endif
#ifdef EALREADY
	{ EALREADY,		"EALREADY - Connection already in progress"},
#endif
#ifdef EBADMSG
	{ EBADMSG,		"EBADMSG - Bad message"},
#endif
#ifdef ECONNABORTED
	{ ECONNABORTED,		"ECONNABORTED - Connection abort"},
#endif
#ifdef ECONNREFUSED
	{ ECONNREFUSED,		"ECONNREFUSED - Connection refused"},
#endif
#ifdef ECONNRESET
	{ ECONNRESET,		"ECONNRESET - Connection reset"},
#endif
#ifdef EDESTADDRREQ
	{ EDESTADDRREQ,		"EDESTADDRREQ - Destination address required"},
#endif
#ifdef EDQUOT
	{ EDQUOT,		"EDQUOT - Reserved"},
#endif
#ifdef EHOSTUNREACH
	{ EHOSTUNREACH,		"EHOSTUNREACH - Destination host cannot be reached"},
#endif
#ifdef EINPROGRESS
	{ EINPROGRESS,		"EINPROGRESS - Connection in progress"},
#endif
#ifdef EISCONN
	{ EISCONN,		"EISCONN - Socket is connected"},
#endif
#ifdef ELOOP
	{ ELOOP,		"ELOOP - Too many levels of symbolic links"},
#endif
#ifdef EMSGSIZE
	{ EMSGSIZE,		"EMSGSIZE - Message too large"},
#endif
#ifdef EMULTIHOP
	{ EMULTIHOP,		"EMULTIHOP - Multihop is not allowed"},
#endif
#ifdef ENETDOWN
	{ ENETDOWN,		"ENETDOWN - The local interface to use to reach the destination is down"},
#endif
#ifdef ENETUNREACH
	{ ENETUNREACH,		"ENETUNREACH - Network unreachable"},
#endif
#ifdef ENOBUFS
	{ ENOBUFS,		"ENOBUFS - No buffer space available"},
#endif
#ifdef ENOLINK
	{ ENOLINK,		"ENOLINK - The link has been severed"},
#endif
#ifdef ENOPROTOOPT
	{ ENOPROTOOPT,		"ENOPROTOOPT - Protocol not available"},
#endif
#ifdef ENOSR
	{ ENOSR,		"ENOSR - No STREAM resources"},
#endif
#ifdef ENOSTR
	{ ENOSTR,		"ENOSTR - Not a STREAM"},
#endif
#ifdef ENOTCONN
	{ ENOTCONN,		"ENOTCONN - Socket not connected"},
#endif
#ifdef ENOTSOCK
	{ ENOTSOCK,		"ENOTSOCK - Not a socket"},
#endif
#ifdef EOPNOTSUPP
	{ EOPNOTSUPP,		"EOPNOTSUPP - Operation not supported on socket"},
#endif
#ifdef EOVERFLOW
	{ EOVERFLOW,		"EOVERFLOW - value too large to be stored in data type"},
#endif
#ifdef EPROTO
	{ EPROTO,		"EPROTO - Protocol error"},
#endif
#ifdef EPROTONOSUPPORT
	{ EPROTONOSUPPORT,	"EPROTONOSUPPORT - Protocol not supported"},
#endif
#ifdef EPROTOTYPE
	{ EPROTOTYPE,		"EPROTOTYPE - Socket type not supported"},
#endif
#ifdef ESTALE
	{ ESTALE,		"ESTALE - The file handle is stale"},
#endif
#ifdef ETIME
	{ ETIME,		"ETIME - STREAM ioctl timeout"},
#endif
#ifdef ETIMEDOUT
	{ ETIMEDOUT,		"ETIMEDOUT - Connection timed out"},
#endif
#ifdef EWOULDBLOCK
	{ EWOULDBLOCK,		"EWOULDBLOCK - No more processes"},
#endif
	{ 0,			"0 - No error" }
};
#define	NERRS	(sizeof(errz) / sizeof(struct errz_t))

/*
** err_lookup - Look up symbolic name of an error
**
**	searches through error structure for matching error
**	number and returns associated string.
**	thus structure is very portable and can be sparse
**	all errnos are required but they are allowed to be absent
*/


char *err_lookup(num)
int num;
{
	static char foo[256];
	int	i;

	for(i=0; i<NERRS; i++) {
		if(errz[i].err == num) {
			(void) sprintf(foo, "%d(%s)", num, errz[i].errname);
			return foo;
		}
	}
	(void) sprintf(foo, "%d(error definition not known)", num);
	return foo;
}
