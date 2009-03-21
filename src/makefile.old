#
#	SCCS: @(#)makefile	1.7 (98/09/22)
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
# SCCS:   	@(#)makefile	1.7 98/09/22 TETware release 3.3
# NAME:		makefile
# PRODUCT:	TETware
# AUTHOR:	Geoff Clare, UniSoft Ltd.
# DATE CREATED:	August 1996
#
# DESCRIPTION:
#	TETWare top-level makefile
# 
# MODIFICATIONS:
#	Geoff Clare, UniSoft Ltd., Sept 1996
#	Changes for TETware-Lite
#
#	Geoff Clare, UniSoft Ltd., Oct 1996
#	Skip perl API if perl not available
#
#	Andrew Dingwall, UniSoft Ltd., June 1998
#	Added the scripts directory.
#
#	Andrew Dingwall, UniSoft Ltd., September 1998
#	added compat_clean targets
#
#       Andrew Josey, The Open Group, May 2001
#       Minor update to make compat
# ************************************************************************

DIRS = tet3 xpg3sh/api ksh/api scripts # not perl 

first_make_rule: all

all install CLEAN clean CLOBBER clobber FORCE FRC: defines.mk
	@case $$MAKEFLAGS in *k*) set +e;; esac; \
	for i in $(DIRS); do echo $$i...; ( cd $$i && $(MAKE) $@ ); done; \
	x=`(perl -e 'exit 0') 2>&1 || true`; \
	if test "$$x" = "" -o \( $@ != all -a $@ != install \); \
	then echo perl...; ( cd perl && $(MAKE) $@ ); \
	else echo 'perl...   skipped (cannot execute perl)'; \
	fi

# remainder is all to produce duplicate targets in TET/ETET/dTET2 locations
# on UNIX systems for backwards compatibility with previous TET implementations

include defines.mk

# source directories
INCDIR  = ../inc/tet3
LIBDIR  = ../lib/tet3

# directories that will hold the compatibility links
TETINC  = ../inc/posix_c
TETLIB  = ../lib/posix_c
DTETINC = ../inc/dtet2
DTETLIB = ../lib/dtet2

COMPAT_DIRS = $(TETINC) $(TETLIB) $(DTETINC) $(DTETLIB)

# compatibility links that are always installed
COMPAT_FILES = $(TETINC)/tet_api.h $(DTETINC)/tet_api.h \
		$(TETINC)/tet_jrnl.h $(DTETINC)/tet_jrnl.h \
		$(TETLIB)/libapi$A $(DTETLIB)/libapi$A \
		$(TETLIB)/tcm$O $(DTETLIB)/tcm$O \
		$(TETLIB)/tcmchild$O $(DTETLIB)/tcmchild$O 

# compatibility links that are only installed if the corresponding TETware
# files are supported on this system
COMPAT_FILES_OPT = $(DTETLIB)/tcmrem$O \
		$(TETLIB)/libCtcm$A $(TETLIB)/libCtcmc$A

# published targets
compat compat_clean:
	@case `uname -s` in					\
	Windows_NT|Windows_95|DOS)				\
		echo "make $@ not suported on Win32 systems"	\
		exit 1						\
		;;						\
	*)							\
		$(MAKE) unix_$@					\
		;;						\
	esac

# targets below here are unpublished (private) targets
# and should not be invoked directly by a user
unix_compat: $(COMPAT_DIRS) $(COMPAT_FILES) compat_files_opt

unix_compat_clean:
	rm -f $(COMPAT_FILES) $(COMPAT_FILES_OPT)
	rmdir $(COMPAT_DIRS) 2> /dev/null || true

$(COMPAT_DIRS):
	mkdir $@

# compatibility links that are always installed
$(TETINC)/tet_api.h $(DTETINC)/tet_api.h: $(INCDIR)/tet_api.h
	rm -f $@
	ln $(INCDIR)/tet_api.h $@

$(TETINC)/tet_jrnl.h $(DTETINC)/tet_jrnl.h: $(INCDIR)/tet_jrnl.h
	rm -f $@
	ln $(INCDIR)/tet_jrnl.h $@

$(TETLIB)/libapi$A $(DTETLIB)/libapi$A: $(LIBDIR)/libapi$A
	rm -f $@
	ln $(LIBDIR)/libapi$A $@

$(TETLIB)/tcm$O $(DTETLIB)/tcm$O: $(LIBDIR)/tcm$O
	rm -f $@
	ln $(LIBDIR)/tcm$O $@

$(TETLIB)/tcmchild$O $(DTETLIB)/tcmchild$O: $(LIBDIR)/tcmchild$O
	rm -f $@
	ln $(LIBDIR)/tcmchild$O $@

# compatibility links that are only installed if the corresponding TETware
# files are supported on this system
compat_files_opt:
	@test ! -f $(LIBDIR)/tcmrem$O || $(MAKE) $(DTETLIB)/tcmrem$O
	@test ! -f $(LIBDIR)/Ctcm$O || $(MAKE) $(TETLIB)/libCtcm$A
	@test ! -f $(LIBDIR)/Ctcmchild$O || $(MAKE) $(TETLIB)/libCtcmc$A

$(DTETLIB)/tcmrem$O: $(LIBDIR)/tcmrem$O
	rm -f $@
	ln $(LIBDIR)/tcmrem$O $@

$(TETLIB)/libCtcm$A: $(LIBDIR)/Ctcm$O
	$(AR) rv $@ $(LIBDIR)/Ctcm$O
	$(RANLIB) $@

$(TETLIB)/libCtcmc$A: $(LIBDIR)/Ctcmchild$O
	$(AR) rv $@ $(LIBDIR)/Ctcmchild$O
	$(RANLIB) $@

