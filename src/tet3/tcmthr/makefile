#
#	SCCS: @(#)makefile	1.10 (98/09/01)
#
#	UniSoft Ltd., London, England
#
# (C) Copyright 1996 X/Open Company Limited
#
# All rights reserved.  No part of this source code may be reproduced,
# stored in a retrieval system, or transmitted, in any form or by any
# means, electronic, mechanical, photocopying, recording or otherwise,
# except as stated in the end-user licence agreement, without the prior
# permission of the copyright owners.
# A copy of the end-user licence agreement is contained in the file
# Licence which accompanies this distribution.
# 
# X/Open and the 'X' symbol are trademarks of X/Open Company Limited in
# the UK and other countries.
#
# ************************************************************************
#
# SCCS:   	@(#)makefile	1.10 98/09/01
# NAME:		makefile
# PRODUCT:	TETware
# AUTHOR:	Geoff Clare, UniSoft Ltd.
# DATE CREATED:	August 1996
#
# DESCRIPTION:
#	tcmthr makefile
# 
# MODIFICATIONS:
#	Geoff Clare, UniSoft Ltd., Oct 1996
#	Restructured tcm source to avoid "ld -r".
#	Use ../tcm/shared.mk.
#
#	Andrew Dingwall, UniSoft Ltd., July 1998
#	Added support for shared API libraries.
#
# ************************************************************************

include ../../defines.mk
include ../ts.mk

LOCAL_TET_CDEFS = $(TET_THR_CDEFS)
LOCAL_DTET_CDEFS = $(DTET_THR_CDEFS)
LOCAL_CDEFS = -DTET_THREADS
LOCAL_COPTS = $(THR_COPTS)
LOCAL_CC = $(CC)

# TET_CFLAGS and DTET_CFLAGS are set in ../common.mk
include ../common.mk


LIBNAME = $(LIBTHRAPI)

# generic C build targets
ALL_GN = tcm$O tcmchild$O
TARGETS_GN = $(LIB)/thrtcm$O $(LIB)/thrtcmchild$O

# additional targets when building the TCM in Distributed TETware
# (tcmrem$O isn't supported in a thread-safe API)
ALL_DIST =
TARGETS_DIST =

# this sets TCM_OFILES_TS
include ../tcm/ts.mk

# C build targets
# (tcmrem$O isn't supported in the thread-safe API)
ALL = $(ALL_GN)
TARGETS = $(TARGETS_GN)

# C++ build targets
# (tcmrem$O isn't supported in the C++ API)
ALLC = Ctcm$O Ctcmchild$O
TARGETSC = $(LIB)/Cthrtcm$O $(LIB)/Cthrtcmchild$O

all: $(ALL) lib_made

allC: $(ALLC)

install: $(TARGETS) lib_made

installC: $(TARGETSC)

# this sets TCM_OFILES
TCMSRC = ../tcm/
APISHLIBSRC =
include ../tcm/shared.mk

$(LIB)/thrtcm$O: tcm$O dtcm$O
	ld -r -o $@ tcm$O dtcm$O

$(LIB)/thrtcmchild$O: tcmchild$O
	cp $? $@

$(LIB)/Cthrtcm$O: Ctcm$O dtcm$O
	ld -r -o $@ Ctcm$O dtcm$O

$(LIB)/Cthrtcmchild$O: Ctcmchild$O
	cp $? $@

OFILES = $(TCM_OFILES)

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
	rm -f $(OFILES) $(ALL) $(ALLC) dynlink_gen_made

CLOBBER clobber: clean
	rm -f $(TARGETS) $(TARGETSC) lib_made

FORCE FRC: clobber all


# remove suffix rules from this makefile
# all .o files are made by explicit rules
.SUFFIXES:

.SUFFIXES: .none

