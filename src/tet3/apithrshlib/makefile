#
#	SCCS: @(#)makefile	1.1 (98/09/01)
#
#	UniSoft Ltd., London, England
#
# Copyright (c) 1998 The Open Group
# All rights reserved.
#
# No part of this source code may be reproduced, stored in a retrieval
# system, or transmitted, in any form or by any means, electronic,
# mechanical, photocopying, recording or otherwise, except as stated in
# the end-user licence agreement, without the prior permission of the
# copyright owners.
# A copy of the end-user licence agreement is contained in the file
# Licence which accompanies this distribution.
# 
# Motif, OSF/1, UNIX and the "X" device are registered trademarks and
# IT DialTone and The Open Group are trademarks of The Open Group in
# the US and other countries.
#
# X/Open is a trademark of X/Open Company Limited in the UK and other
# countries.
#
# ************************************************************************
#
# SCCS:   	@(#)makefile	1.1 98/09/01 TETware release 3.3
# NAME:		makefile
# PRODUCT:	TETware
# AUTHOR:	Andrew Dingwall, UniSoft Ltd.
# DATE CREATED:	August 1998
#
# DESCRIPTION:
#	makefile used to build the shared version of the thread-safe
#	API library
# 
# MODIFICATIONS:
# 
# ************************************************************************

include ../../defines.mk
include ../ts.mk

LOCAL_TET_CDEFS = $(TET_THR_CDEFS)
LOCAL_DTET_CDEFS = $(DTET_THR_CDEFS)
LOCAL_CDEFS = -DTET_THREADS -DTET_SHLIB_SOURCE
LOCAL_COPTS = $(THR_COPTS) $(SHLIB_COPTS)
LOCAL_CC = $(SHLIB_CC)

# TET_CFLAGS and DTET_CFLAGS are set in ../common.mk
include ../common.mk


# the main library name;
# on Win32 systems this is the name of the import library
LIBNAME = libthrapi_s$(SO)

# The name of the DLL on Win32 systems.
# The DLL is a byproduct of the process that builds the shared library.
# Since this file is only generated on a Win32 system, it can't be used
# as a target or as a dependency in a platform-independent makefile;
# instead, a proxy target called lib_installed is used to determine when
# the DLL needs to be installed.
DLLNAME = libthrapi_s.dll
# The name of the export definition file on Win32 systems.
# This file is also a byproduct o$(DLLNAME) f the process that builds the shared library.
# We don't need this file so it just gets deleted.
EXPNAME = libthrapi_s.exp

ALL = $(LIBNAME)

TARGETS = $(LIB)/$(LIBNAME) lib_installed


all: $(ALL)

install: $(TARGETS)

$(LIB)/$(LIBNAME): $(LIBNAME)
	rm -f $@
	cp $? $@

lib_installed: $(LIBNAME)
	@set -x;					\
	case `uname -s` in 				\
	Windows_NT|Windows_95|DOS) 			\
		rm -f $(BIN)/$(DLLNAME);		\
		cp $(DLLNAME) $(BIN)/$(DLLNAME);	\
		;;					\
	esac
	touch $@

# dynlink.gen is a byproduct of building the shared API library on a
# Win32 system
dynlink.gen:
	@set -x;					\
	case `uname -s` in 				\
	Windows_NT|Windows_95|DOS) 			\
		$(MAKE) $(LIBNAME);			\
		;;					\
	*)						\
		touch $@;				\
	esac


# tcm/shared.mk contains a definition of TCM_SHARED_OFILES
TCMSRC = ../tcm/
include ../tcm/shared.mk

# apithr/shared.mk contains a definition of THR_SHARED_OFILES
THR_APISRC = ../apithr/
include ../apithr/shared.mk

# apilib/shared.mk contains a definition of API_SHARED_THR_OFILES
# and APITHR_SHARED_OFILES
APISRC = ../apilib/
include ../apilib/shared.mk

# the include ../servlib/shared.mk is done in ts.mk if needed

# dtet2lib/shared.mk contains a definition of DTET_SHARED_OFILES
DTETSRC = ../dtet2lib/
include ../dtet2lib/shared.mk

# ts.mk contains a definition of TS_SHARED_OFILES and SERV_SHARED_OFILES
include ts.mk

OFILES = $(API_SHARED_THR_OFILES) $(APITHR_SHARED_OFILES) \
	$(TCM_SHARED_OFILES) $(THR_SHARED_OFILES) $(SERV_SHARED_OFILES) \
	$(TS_SHARED_OFILES) $(DTET_SHARED_OFILES)

$(LIBNAME): $(OFILES)
	$(SHLIB_BUILD) -o $@ $(OFILES) $(THRSHLIB_BUILD_END)
	$(MCS) -c $@
	@set -x;				\
	case `uname -s` in			\
	Windows_NT|Windows_95|DOS)		\
		rm -f $(EXPNAME);		\
		;;				\
	esac

.PRECIOUS: $(LIBNAME)


CLEAN clean:
	rm -f $(ALL) $(OFILES) dlcheck$O *.sym dynlink.gen dlcheck.gen
	@set -x;				\
	case `uname -s` in			\
	Windows_NT|Windows_95|DOS)		\
		rm -f $(DLLNAME) $(EXPNAME);	\
		;;				\
	esac

CLOBBER clobber: clean
	rm -f $(TARGETS)
	@set -x;				\
	case `uname -s` in			\
	Windows_NT|Windows_95|DOS)		\
		rm -f $(BIN)/$(DLLNAME);	\
		;;				\
	esac

FORCE FRC: clobber all


# remove suffix rules from this makefile
# all .o files are made by explicit rules
.SUFFIXES:

.SUFFIXES: .none


