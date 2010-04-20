/*
 *      SCCS:  @(#)errmap.c	1.7 (98/08/28)
 *
 *	UniSoft Ltd., London, England
 *
 * (C) Copyright 1993 X/Open Company Limited
 *
 * All rights reserved.  No part of this source code may be reproduced,
 * stored in a retrieval system, or transmitted, in any form or by any
 * means, electronic, mechanical, photocopying, recording or otherwise,
 * except as stated in the end-user licence agreement, without the prior
 * permission of the copyright owners.
 *
 * X/Open and the 'X' symbol are trademarks of X/Open Company Limited in
 * the UK and other countries.
 */

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

/************************************************************************

SCCS:   	@(#)errmap.c	1.7 98/08/28 TETware release 3.3
NAME:		errmap.c
PRODUCT:	TETware
AUTHOR:		Andrew Dingwall, UniSoft Ltd.
DATE CREATED:	January 1993

DESCRIPTION:
	error map - used to map between:
		1) common errno values and DTET message reply codes in
			maperr() and unmaperr()
		2) errno values and symbolic errno names in tet_errname()

	if a DTET message reply code does not have a corresponding errno
	value on a particular system, then a dummy map entry must appear

	the symbolic errno names are collected from <errno.h> files
	on several systems - however, your mileage may vary

MODIFICATIONS:

	Andrew Dingwall, UniSoft Ltd., February 1998
	Corrected mapping of ENOENT.

	Aaron Plattner, April 2010
	Fixed warnings when compiled with GCC's -Wall option.

************************************************************************/

#include <errno.h>
#ifndef TET_LITE	/* -START-LITE-CUT- */
#endif /* !TET_LITE */	/* -END-LITE-CUT- */
#include "dtmac.h"
#include "dtmsg.h"
#include "errmap.h"


struct errmap tet_errmap[] = {

	/* first, the values that have DTET message reply code equivalents */
 	{ 0, ER_OK, "No Error" },

#ifdef E2BIG
	{ E2BIG, ER_E2BIG, "E2BIG" },
#else
	{ -1, ER_E2BIG, "" },
#endif

#ifdef EACCES
	{ EACCES, ER_EACCES, "EACCES" },
#else
	{ -1, ER_EACCES, "" },
#endif

#ifdef EAGAIN
	{ EAGAIN, ER_EAGAIN, "EAGAIN" },
#else
	{ -1, ER_EAGAIN, "" },
#endif

#ifdef EBADF
	{ EBADF, ER_EBADF, "EBADF" },
#else
	{ -1, ER_EBADF, "" },
#endif

#ifdef EBUSY
	{ EBUSY, ER_EBUSY, "EBUSY" },
#else
	{ -1, ER_EBUSY, "" },
#endif

#ifdef ECHILD
	{ ECHILD, ER_ECHILD, "ECHILD" },
#else
	{ -1, ER_ECHILD, "" },
#endif

#ifdef EEXIST
	{ EEXIST, ER_EEXIST, "EEXIST" },
#else
	{ -1, ER_EEXIST, "" },
#endif

#ifdef EFAULT
	{ EFAULT, ER_EFAULT, "EFAULT" },
#else
	{ -1, ER_EFAULT, "" },
#endif

#ifdef EFBIG
	{ EFBIG, ER_EFBIG, "EFBIG" },
#else
	{ -1, ER_EFBIG, "" },
#endif

#ifdef EINTR
	{ EINTR, ER_EINTR, "EINTR" },
#else
	{ -1, ER_EINTR, "" },
#endif

#ifdef EINVAL
	{ EINVAL, ER_EINVAL, "EINVAL" },
#else
	{ -1, ER_EINVAL, "" },
#endif

#ifdef EIO
	{ EIO, ER_EIO, "EIO" },
#else
	{ -1, ER_EIO, "" },
#endif

#ifdef EISDIR
	{ EISDIR, ER_EISDIR, "EISDIR" },
#else
	{ -1, ER_EISDIR, "" },
#endif

#ifdef EMFILE
	{ EMFILE, ER_EMFILE, "EMFILE" },
#else
	{ -1, ER_EMFILE, "" },
#endif

#ifdef EMLINK
	{ EMLINK, ER_EMLINK, "EMLINK" },
#else
	{ -1, ER_EMLINK, "" },
#endif

#ifdef ENFILE
	{ ENFILE, ER_ENFILE, "ENFILE" },
#else
	{ -1, ER_ENFILE, "" },
#endif

#ifdef ENODEV
	{ ENODEV, ER_ENODEV, "ENODEV" },
#else
	{ -1, ER_ENODEV, "" },
#endif

#ifdef ENOENT
	{ ENOENT, ER_ENOENT, "ENOENT" },
#else
	{ -1, ER_NOENT, "" },
#endif

#ifdef ENOEXEC
	{ ENOEXEC, ER_ENOEXEC, "ENOEXEC" },
#else
	{ -1, ER_ENOEXEC, "" },
#endif

#ifdef ENOMEM
	{ ENOMEM, ER_ENOMEM, "ENOMEM" },
#else
	{ -1, ER_ENOMEM, "" },
#endif

#ifdef ENOSPC
	{ ENOSPC, ER_ENOSPC, "ENOSPC" },
#else
	{ -1, ER_ENOSPC, "" },
#endif

#ifdef ENOTBLK
	{ ENOTBLK, ER_ENOTBLK, "ENOTBLK" },
#else
	{ -1, ER_ENOTBLK, "" },
#endif

#ifdef ENOTDIR
	{ ENOTDIR, ER_ENOTDIR, "ENOTDIR" },
#else
	{ -1, ER_ENOTDIR, "" },
#endif

#ifdef ENOTEMPTY
	{ ENOTEMPTY, ER_ENOTEMPTY, "ENOTEMPTY" },
#else
	{ -1, ER_ENOTEMPTY, "" },
#endif

#ifdef ENOTTY
	{ ENOTTY, ER_ENOTTY, "ENOTTY" },
#else
	{ -1, ER_ENOTTY, "" },
#endif

#ifdef ENXIO
	{ ENXIO, ER_ENXIO, "ENXIO" },
#else
	{ -1, ER_ENXIO, "" },
#endif

#ifdef EPERM
	{ EPERM, ER_EPERM, "EPERM" },
#else
	{ -1, ER_EPERM, "" },
#endif

#ifdef EPIPE
	{ EPIPE, ER_EPIPE, "EPIPE" },
#else
	{ -1, ER_EPIPE, "" },
#endif

#ifdef EROFS
	{ EROFS, ER_EROFS, "EROFS" },
#else
	{ -1, ER_EROFS, "" },
#endif

#ifdef ESPIPE
	{ ESPIPE, ER_ESPIPE, "ESPIPE" },
#else
	{ -1, ER_ESPIPE, "" },
#endif

#ifdef ESRCH
	{ ESRCH, ER_ESRCH, "ESRCH" },
#else
	{ -1, ER_ESRCH, "" },
#endif

#ifdef ETXTBSY
	{ ETXTBSY, ER_ETXTBSY, "ETXTBSY" },
#else
	{ -1, ER_ETXTBSY, "" },
#endif

#ifdef EXDEV
	{ EXDEV, ER_EXDEV, "EXDEV" },
#else
	{ -1, ER_EXDEV, "" },
#endif

	/* then, the rest of the errno values */

#ifdef EADDRINUSE
	{ EADDRINUSE, 0, "EADDRINUSE" },
#endif

#ifdef EADDRNOTAVAIL
	{ EADDRNOTAVAIL, 0, "EADDRNOTAVAIL" },
#endif

#ifdef EADV
	{ EADV, 0, "EADV" },
#endif

#ifdef EAFNOSUPPORT
	{ EAFNOSUPPORT, 0, "EAFNOSUPPORT" },
#endif

#ifdef EALREADY
	{ EALREADY, 0, "EALREADY" },
#endif

#ifdef EBADE
	{ EBADE, 0, "EBADE" },
#endif

#ifdef EBADFD
	{ EBADFD, 0, "EBADFD" },
#endif

#ifdef EBADMSG
	{ EBADMSG, 0, "EBADMSG" },
#endif

#ifdef EBADR
	{ EBADR, 0, "EBADR" },
#endif

#ifdef EBADRQC
	{ EBADRQC, 0, "EBADRQC" },
#endif

#ifdef EBADSLT
	{ EBADSLT, 0, "EBADSLT" },
#endif

#ifdef EBFONT
	{ EBFONT, 0, "EBFONT" },
#endif

#ifdef ECANCELED
	{ ECANCELED, 0, "ECANCELED" },
#endif

#ifdef ECHRNG
	{ ECHRNG, 0, "ECHRNG" },
#endif

#ifdef ECLONEME
	{ ECLONEME, 0, "ECLONEME" },
#endif

#ifdef ECOMM
	{ ECOMM, 0, "ECOMM" },
#endif

#ifdef ECONNABORTED
	{ ECONNABORTED, 0, "ECONNABORTED" },
#endif

#ifdef ECONNREFUSED
	{ ECONNREFUSED, 0, "ECONNREFUSED" },
#endif

#ifdef ECONNRESET
	{ ECONNRESET, 0, "ECONNRESET" },
#endif

#ifdef EDEADLK
	{ EDEADLK, 0, "EDEADLK" },
#endif

#ifdef EDEADLOCK
	{ EDEADLOCK, 0, "EDEADLOCK" },
#endif

#ifdef EDESTADDRREQ
	{ EDESTADDRREQ, 0, "EDESTADDRREQ" },
#endif

#ifdef EDIST
	{ EDIST, 0, "EDIST" },
#endif

#ifdef EDOM
	{ EDOM, 0, "EDOM" },
#endif

#ifdef EDOTDOT
	{ EDOTDOT, 0, "EDOTDOT" },
#endif

#ifdef EDQUOT
	{ EDQUOT, 0, "EDQUOT" },
#endif

#ifdef EFORMAT
	{ EFORMAT, 0, "EFORMAT" },
#endif

#ifdef EHOSTDOWN
	{ EHOSTDOWN, 0, "EHOSTDOWN" },
#endif

#ifdef EHOSTUNREACH
	{ EHOSTUNREACH, 0, "EHOSTUNREACH" },
#endif

#ifdef EIDRM
	{ EIDRM, 0, "EIDRM" },
#endif

#ifdef EILSEQ
	{ EILSEQ, 0, "EILSEQ" },
#endif

#ifdef EINIT
	{ EINIT, 0, "EINIT" },
#endif

#ifdef EINPROGRESS
	{ EINPROGRESS, 0, "EINPROGRESS" },
#endif

#ifdef EISCONN
	{ EISCONN, 0, "EISCONN" },
#endif

#ifdef EISNAM
	{ EISNAM, 0, "EISNAM" },
#endif

#ifdef EL2HLT
	{ EL2HLT, 0, "EL2HLT" },
#endif

#ifdef EL2NSYNC
	{ EL2NSYNC, 0, "EL2NSYNC" },
#endif

#ifdef EL3HLT
	{ EL3HLT, 0, "EL3HLT" },
#endif

#ifdef EL3RST
	{ EL3RST, 0, "EL3RST" },
#endif

#ifdef ELIBACC
	{ ELIBACC, 0, "ELIBACC" },
#endif

#ifdef ELIBBAD
	{ ELIBBAD, 0, "ELIBBAD" },
#endif

#ifdef ELIBEXEC
	{ ELIBEXEC, 0, "ELIBEXEC" },
#endif

#ifdef ELIBMAX
	{ ELIBMAX, 0, "ELIBMAX" },
#endif

#ifdef ELIBSCN
	{ ELIBSCN, 0, "ELIBSCN" },
#endif

#ifdef ELNRNG
	{ ELNRNG, 0, "ELNRNG" },
#endif

#ifdef ELOOP
	{ ELOOP, 0, "ELOOP" },
#endif

#ifdef EMEDIA
	{ EMEDIA, 0, "EMEDIA" },
#endif

#ifdef EMSGSIZE
	{ EMSGSIZE, 0, "EMSGSIZE" },
#endif

#ifdef EMULTIHOP
	{ EMULTIHOP, 0, "EMULTIHOP" },
#endif

#ifdef ENAMETOOLONG
	{ ENAMETOOLONG, 0, "ENAMETOOLONG" },
#endif

#ifdef ENAVAIL
	{ ENAVAIL, 0, "ENAVAIL" },
#endif

#ifdef ENET
	{ ENET, 0, "ENET" },
#endif

#ifdef ENETDOWN
	{ ENETDOWN, 0, "ENETDOWN" },
#endif

#ifdef ENETRESET
	{ ENETRESET, 0, "ENETRESET" },
#endif

#ifdef ENETUNREACH
	{ ENETUNREACH, 0, "ENETUNREACH" },
#endif

#ifdef ENOANO
	{ ENOANO, 0, "ENOANO" },
#endif

#ifdef ENOATTR
	{ ENOATTR, 0, "ENOATTR" },
#endif

#ifdef ENOBUFS
	{ ENOBUFS, 0, "ENOBUFS" },
#endif

#ifdef ENOCONNECT
	{ ENOCONNECT, 0, "ENOCONNECT" },
#endif

#ifdef ENOCSI
	{ ENOCSI, 0, "ENOCSI" },
#endif

#ifdef ENODATA
	{ ENODATA, 0, "ENODATA" },
#endif

#ifdef ENOLCK
	{ ENOLCK, 0, "ENOLCK" },
#endif

#ifdef ENOLINK
	{ ENOLINK, 0, "ENOLINK" },
#endif

#ifdef ENOMSG
	{ ENOMSG, 0, "ENOMSG" },
#endif

#ifdef ENONET
	{ ENONET, 0, "ENONET" },
#endif

#ifdef ENOPKG
	{ ENOPKG, 0, "ENOPKG" },
#endif

#ifdef ENOPROTOOPT
	{ ENOPROTOOPT, 0, "ENOPROTOOPT" },
#endif

#ifdef ENOSR
	{ ENOSR, 0, "ENOSR" },
#endif

#ifdef ENOSTR
	{ ENOSTR, 0, "ENOSTR" },
#endif

#ifdef ENOSYS
	{ ENOSYS, 0, "ENOSYS" },
#endif

#ifdef ENOTCONN
	{ ENOTCONN, 0, "ENOTCONN" },
#endif

#ifdef ENOTNAM
	{ ENOTNAM, 0, "ENOTNAM" },
#endif

#ifdef ENOTREADY
	{ ENOTREADY, 0, "ENOTREADY" },
#endif

#ifdef ENOTRUST
	{ ENOTRUST, 0, "ENOTRUST" },
#endif

#ifdef ENOTSOCK
	{ ENOTSOCK, 0, "ENOTSOCK" },
#endif

#ifdef ENOTUNIQ
	{ ENOTUNIQ, 0, "ENOTUNIQ" },
#endif

#ifdef EOPCOMPLETE
	{ EOPCOMPLETE, 0, "EOPCOMPLETE" },
#endif

#ifdef EOPNOTSUPP
	{ EOPNOTSUPP, 0, "EOPNOTSUPP" },
#endif

#ifdef EOVERFLOW
	{ EOVERFLOW, 0, "EOVERFLOW" },
#endif

#ifdef EPATHREMOTE
	{ EPATHREMOTE, 0, "EPATHREMOTE" },
#endif

#ifdef EPFNOSUPPORT
	{ EPFNOSUPPORT, 0, "EPFNOSUPPORT" },
#endif

#ifdef EPOWERFAIL
	{ EPOWERFAIL, 0, "EPOWERFAIL" },
#endif

#ifdef EPROCLIM
	{ EPROCLIM, 0, "EPROCLIM" },
#endif

#ifdef EPROTO
	{ EPROTO, 0, "EPROTO" },
#endif

#ifdef EPROTONOSUPPORT
	{ EPROTONOSUPPORT, 0, "EPROTONOSUPPORT" },
#endif

#ifdef EPROTOTYPE
	{ EPROTOTYPE, 0, "EPROTOTYPE" },
#endif

#ifdef ERANGE
	{ ERANGE, 0, "ERANGE" },
#endif

#ifdef EREMCHG
	{ EREMCHG, 0, "EREMCHG" },
#endif

#ifdef EREMDEV
	{ EREMDEV, 0, "EREMDEV" },
#endif

#ifdef EREMOTE
	{ EREMOTE, 0, "EREMOTE" },
#endif

#ifdef EREMOTEIO
	{ EREMOTEIO, 0, "EREMOTEIO" },
#endif

#ifdef EREMOTERELEASE
	{ EREMOTERELEASE, 0, "EREMOTERELEASE" },
#endif

#ifdef ERESTART
	{ ERESTART, 0, "ERESTART" },
#endif

#ifdef ERFACOMPLETE
	{ ERFACOMPLETE, 0, "ERFACOMPLETE" },
#endif

#ifdef ERREMOTE
	{ ERREMOTE, 0, "ERREMOTE" },
#endif

#ifdef ESAD
	{ ESAD, 0, "ESAD" },
#endif

#ifdef ESHUTDOWN
	{ ESHUTDOWN, 0, "ESHUTDOWN" },
#endif

#ifdef ESOCKTNOSUPPORT
	{ ESOCKTNOSUPPORT, 0, "ESOCKTNOSUPPORT" },
#endif

#ifdef ESOFT
	{ ESOFT, 0, "ESOFT" },
#endif

#ifdef ESRMNT
	{ ESRMNT, 0, "ESRMNT" },
#endif

#ifdef ESTALE
	{ ESTALE, 0, "ESTALE" },
#endif

#ifdef ESTRPIPE
	{ ESTRPIPE, 0, "ESTRPIPE" },
#endif

#ifdef ETIME
	{ ETIME, 0, "ETIME" },
#endif

#ifdef ETIMEDOUT
	{ ETIMEDOUT, 0, "ETIMEDOUT" },
#endif

#ifdef ETOOMANYREFS
	{ ETOOMANYREFS, 0, "ETOOMANYREFS" },
#endif

#ifdef EUCLEAN
	{ EUCLEAN, 0, "EUCLEAN" },
#endif

#ifdef EUNATCH
	{ EUNATCH, 0, "EUNATCH" },
#endif

#ifdef EUSERS
	{ EUSERS, 0, "EUSERS" },
#endif

#ifdef EWOULDBLOCK
	{ EWOULDBLOCK, 0, "EWOULDBLOCK" },
#endif

#ifdef EWRPROTECT
	{ EWRPROTECT, 0, "EWRPROTECT" },
#endif

#ifdef EXFULL
	{ EXFULL, 0, "EXFULL" },
#endif


#ifndef TET_LITE	/* -START-LITE-CUT- */

	/* finally, the winsock errors on WIN32 */

#endif /* !TET_LITE */	/* -END-LITE-CUT- */

};

int tet_Nerrmap = sizeof tet_errmap / sizeof tet_errmap[0];

