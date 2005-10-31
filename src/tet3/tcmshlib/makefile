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
#	makefile used to build the shared library tcms and the static
#	part of the API shared library
# 
# MODIFICATIONS:
# 
# ************************************************************************

include ../../defines.mk
include ../ts.mk

LOCAL_TET_CDEFS = $(TET_CDEFS)
LOCAL_DTET_CDEFS = $(DTET_CDEFS)
LOCAL_CDEFS = -DTET_SHLIB
LOCAL_COPTS = $(COPTS)
LOCAL_CC = $(CC)

# TET_CFLAGS and DTET_CFLAGS are set in ../common.mk
include ../common.mk


LIBNAME = $(LIB)/libtcm_s$A

# generic C build targets
ALL_GN = tcm$O tcmchild$O
TARGETS_GN = $(LIB)/tcm_s$O $(LIB)/tcmchild_s$O

# additional targets when building the TCM in Distributed TETware
ALL_DIST = tcmrem$O
TARGETS_DIST_S = $(LIB)/tcmrem_s$O

# this sets ALL_TS, TARGETS_TS_S and TCM_OFILES_TS
include ../tcm/ts.mk

# C build targets
ALL = $(ALL_GN) $(ALL_TS)
TARGETS = $(TARGETS_GN) $(TARGETS_TS_S)

# C++ build targets
# (tcmrem$O isn't supported in the C++ API)
ALLC = Ctcm$O Ctcmchild$O
TARGETSC = $(LIB)/Ctcm_s$O $(LIB)/Ctcmchild_s$O


all: $(ALL) lib_made

allC: $(ALLC)

install: $(TARGETS) lib_made

installC: $(TARGETSC)

# tcm/shared.mk contains a definition of TCM_STATIC_OFILES
TCMSRC = ../tcm/
APISHLIBSRC = ../apishlib/
include ../tcm/shared.mk

# apilib/shared.mk contains a definition of API_STATIC_OFILES
APISRC = ../apilib/
include ../apilib/shared.mk


$(LIB)/tcm_s$O: tcm$O dtcm$O
	ld -r -o $@ tcm$O dtcm$O

$(LIB)/tcmrem_s$O: tcmrem$O
	cp $? $@

$(LIB)/tcmchild_s$O: tcmchild$O
	cp $? $@

$(LIB)/Ctcm_s$O: Ctcm$O dtcm$O
	ld -r -o $@ Ctcm$O dtcm$O

$(LIB)/Ctcmchild_s$O: Ctcmchild$O
	cp $? $@


OFILES = $(TCM_STATIC_OFILES) $(API_STATIC_OFILES)

lib_made: $(OFILES)
	if test -f lib_made; then \
		$(AR) rv $(LIBNAME) $? ;\
	else \
		$(AR) rv $(LIBNAME) `$(LORDER) $(OFILES) | $(TSORT)` ;\
	fi
	$(RANLIB) $(LIBNAME)
	touch lib_made

.PRECIOUS: $(LIBNAME)


CLEAN clean:
	rm -f $(ALL) $(ALLC) $(OFILES) dynlink_gen_made

CLOBBER clobber: clean
	rm -f $(TARGETS) $(TARGETSC) $(LIBNAME) lib_made

FORCE FRC: clobber all


# remove suffix rules from this makefile
# all .o files are made by explicit rules
.SUFFIXES:

.SUFFIXES: .none


