#
# Copyright (c) 2005 X.Org Foundation LLC
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
# of the Software, and to permit persons to whom the Software is furnished to do
# so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
# $Header: /cvs/xtest/xtest/xts5/fonts/Makefile,v 1.1 2005-02-12 15:14:15 anderson Exp $
#
# Copyright (c) Applied Testing and Technology, Inc. 1995
# All Rights Reserved.
#
# Project:     VSW5
#
# File:        vsw5/fonts/Makefile
#
# Description:
#       Makefile for installing VSW5 fonts
#
# Modifications:
# $Log: Makefile,v $
# Revision 1.1  2005-02-12 15:14:15  anderson
# Initial revision
#
# Revision 8.0  1998/12/23 23:22:49  mar
# Branch point for Release 5.0.2
#
# Revision 7.0  1998/10/30 22:40:48  mar
# Branch point for Release 5.0.2b1
#
# Revision 6.0  1998/03/02 05:15:23  tbr
# Branch point for Release 5.0.1
#
# Revision 5.0  1998/01/26 03:11:55  tbr
# Branch point for Release 5.0.1b1
#
# Revision 4.1  1998/01/22 05:29:15  tbr
# req.4.W.00029 vswsr126 vswsr125 vswsr124 vswsr122 vswsr127
# Added new fonts and modified XT_FONTSET to select those fonts
# and realigned the data files associated with certain tests
# to match the expected results when using the new fonts
#
# Revision 4.0  1995/12/15 08:37:39  tbr
# Branch point for Release 5.0.0
#
# Revision 3.1  1995/12/15  00:33:31  andy
# Prepare for GA Release
#

# Portions of this software are based on Xlib and X Protocol Test Suite.
# We have used this material under the terms of its copyright, which grants
# free use, subject to the conditions below.  Note however that those
# portions of this software that are based on the original Test Suite have
# been significantly revised and that all such revisions are copyright (c)
# 1995 Applied Testing and Technology, Inc.  Insomuch as the proprietary
# revisions cannot be separated from the freely copyable material, the net
# result is that use of this software is governed by the ApTest copyright.
# 
# Copyright (c) 1990, 1991  X Consortium
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
# X CONSORTIUM BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
# AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
# 
# Except as contained in this notice, the name of the X Consortium shall not be
# used in advertising or otherwise to promote the sale, use or other dealings
# in this Software without prior written authorization from the X Consortium.
#
# Copyright 1990, 1991 UniSoft Group Limited.
#
# Permission to use, copy, modify, distribute, and sell this software and
# its documentation for any purpose is hereby granted without fee,
# provided that the above copyright notice appear in all copies and that
# both that copyright notice and this permission notice appear in
# supporting documentation, and that the names of MIT and UniSoft not be
# used in advertising or publicity pertaining to distribution of the
# software without specific, written prior permission.  MIT and UniSoft
# make no representations about the suitability of this software for any
# purpose.  It is provided "as is" without express or implied warranty.

CFILES = xtfont0.c xtfont1.c xtfont2.c xtfont3.c xtfont4.c xtfont5.c \
	xtfont6.c
OFILES = xtfont0.o xtfont1.o xtfont2.o xtfont3.o xtfont4.o xtfont5.o \
	xtfont6.o
RM_FILES = *.ln *.o core *.a

##############################################################################

all: libfont.a

libfont.a: $P	$(OFILES)
		$(AR) $@ `$(LORDER) $(OFILES) | $(TSORT)`
		: $(RANLIB) $@

FORCE:		CLOBBER all

LINT:
		$(LINT) $(LINTFLAGS) $(CFILES) $(LINTTCM) $(LINTLIBS)

LINTLIB:	$(LINTFONTS)

$(LINTFONTS):	llib-lfonts.ln
		$(CP) $? $@
		@echo "	$? made and installed"

llib-lfonts.ln:
		$(LINT) -Cfonts $(LINTFLAGS) $(CFILES)

clean:
		$(RM) $(RM_FILES)

clobber:	clean

install: all
	$(CP) libfont.a $(XTESTLIBDIR)
	$(RANLIB) $(XTESTLIBDIR)/libfont.a

# -----------------
#
# NOTE: The way that the fonts are installed is system dependent.
# This part of the Makefile is provided solely as an example.
#
# See the User Guide for more details.
#

FONTSRCS=xtfont0 xtfont1 xtfont2 xtfont3 xtfont4 xtfont5 xtfont6 xtfont7 xtfont8

comp_pcf:
	@ echo "These commands are system dependent - See User Guide"
	@ for f in $(FONTSRCS) ;\
	do \
		(set -x; bdftopcf -t $$f.bdf -o $$f.pcf); \
	done
	mkfontdir

comp_snf:
	@ echo "These commands are system dependent - See User Guide"
	@ for f in $(FONTSRCS) ;\
	do \
		(set -x; bdftosnf $$f.bdf > $$f.snf); \
	done
	mkfontdir

comp_dxpcf:
	@ echo "These commands are system dependent - See User Guide"
	@ for f in $(FONTSRCS) ;\
	do \
		(set -x; dxfc -t $$f.bdf > $$f.pcf); \
	done
	dxmkfontdir

comp_fb:
	@ echo "These commands are system dependent - See User Guide"
	@ for f in $(FONTSRCS) ;\
	do \
		(set -x; convertfont -d . -o $$f $$f.bdf); \
	done
	bldfamily -d .

install_pcf install_dxpcf:
	@ echo "These commands are system dependent - See User Guide"
	@ if [ -d $(XTESTFONTDIR) ]; then set +x; \
		else (set -x; mkdir $(XTESTFONTDIR)); fi
	@ for f in $(FONTSRCS) ;\
	do \
		(set -x; cp $$f.pcf $(XTESTFONTDIR)); \
	done
	cp fonts.dir $(XTESTFONTDIR)

install_snf:
	@ echo "These commands are system dependent - See User Guide"
	@ if [ -d $(XTESTFONTDIR) ]; then set +x; \
		else (set -x; mkdir $(XTESTFONTDIR)); fi
	@ for f in $(FONTSRCS) ;\
	do \
		(set -x; cp $$f.snf $(XTESTFONTDIR)); \
	done
	cp fonts.dir $(XTESTFONTDIR)

install_fb:
	@ echo "These commands are system dependent - See User Guide"
	@ if [ -d $(XTESTFONTDIR) ]; then set +x; \
		else (set -x; mkdir $(XTESTFONTDIR)); fi
	@ for f in $(FONTSRCS) ;\
	do \
		(set -x; cp $$f.fb $$f.ff $(XTESTFONTDIR)); \
	done
