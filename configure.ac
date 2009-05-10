#  Copyright 2009 Red Hat, Inc.
#
#  Permission is hereby granted, free of charge, to any person obtaining a
#  copy of this software and associated documentation files (the "Software"),
#  to deal in the Software without restriction, including without limitation
#  on the rights to use, copy, modify, merge, publish, distribute, sub
#  license, and/or sell copies of the Software, and to permit persons to whom
#  the Software is furnished to do so, subject to the following conditions:
#
#  The above copyright notice and this permission notice (including the next
#  paragraph) shall be included in all copies or substantial portions of the
#  Software.
#
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#  FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT.  IN NO EVENT SHALL
#  ADAM JACKSON BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
#  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
#  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
# Process this file with autoconf to produce a configure script

AC_PREREQ(2.57)
AC_INIT([xtest],
        1.0.0,
        [http://xorg.freedesktop.org/wiki/BuildingXtest],
        XTest)

AC_CONFIG_SRCDIR([Makefile.am])
AC_CONFIG_AUX_DIR(.)
AM_INIT_AUTOMAKE([dist-bzip2 foreign])

AM_MAINTAINER_MODE

AM_CONFIG_HEADER([config.h])

# Checks for programs.
AC_DISABLE_STATIC
AC_PROG_LIBTOOL
AC_PROG_CC
#AM_PROG_CC_C_O

PKG_CHECK_MODULES([XTS], [x11 xext xi xtst])
PKG_CHECK_MODULES([XP], [x11 xext xi xtst])
PKG_CHECK_MODULES([XT], [x11 xext xt xtst])
dnl PKG_CHECK_MODULES([XAW], [x11 xext xt xtst xaw7])

# Checks for header files.
AC_HEADER_STDC

dnl Needed for generating fonts
AC_PATH_PROG([BDFTOPCF], [bdftopcf])
AC_PATH_PROG([MKFONTDIR], [mkfontdir])
if test "x$BDFTOPCF" = x || test "x$MKFONTDIR" = x; then
    AC_MSG_ERROR([bdftopcf and mkfontdir are required to build the test fonts])
fi

dnl Needed for generating tetexec.cfg with xts-config
AC_PATH_PROG([PERL], [perl])
if test "x$PERL" = x; then
    AC_MSG_ERROR([perl is required to run xts-config])
fi

dnl See what display the user wants to use for testing
AC_ARG_WITH([display],
    [AS_HELP_STRING([--with-display=DPY],
        [X display to connect to @<:@default=DISPLAY variable@:>@])],
    [XT_DISPLAY=$withval],
    [XT_DISPLAY=$DISPLAY])
if test "x$XT_DISPLAY" = x; then
    AC_MSG_ERROR([no display specified; set DISPLAY variable or use --with-display])
fi
AC_MSG_CHECKING([display to test])
AC_MSG_RESULT([$XT_DISPLAY])
AC_SUBST([XT_DISPLAY])

AC_CONFIG_FILES([
Makefile
src/Makefile
src/tet3/Makefile
src/tet3/apilib/Makefile
src/tet3/dtet2lib/Makefile
src/tet3/inetlib/Makefile
src/tet3/servlib/Makefile
src/tet3/tcm/Makefile
src/tet3/tcc/Makefile
src/tet3/tcclib/Makefile
xts5/Makefile
xts5/src/Makefile
xts5/src/lib/Makefile
xts5/src/libproto/Makefile
xts5/src/libXR5/Makefile
xts5/src/libXtaw/Makefile
xts5/src/libXtmu/Makefile
xts5/src/libXtTest/Makefile
xts5/src/xim/Makefile
xts5/src/bin/Makefile
xts5/src/bin/mc/Makefile
xts5/fonts/Makefile
xts5/tset/Makefile
xts5/tset/Xproto/Makefile
])

AC_CONFIG_COMMANDS([tetexec.cfg],
    [TET_ROOT=`pwd` DISPLAY=$XT_DISPLAY $PERL -p $srcdir/xts5/bin/xts-config \
        < $srcdir/xts5/tetexec.cfg.in > xts5/tetexec.cfg],
    [PERL="$PERL"; XT_DISPLAY="$XT_DISPLAY"])

AC_OUTPUT
