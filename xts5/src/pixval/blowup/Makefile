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
#
# Copyright (c) Applied Testing and Technology, Inc. 1995
# All Rights Reserved.
# Copyright 1990, 1991 by the Massachusetts Institute of Technology and
# UniSoft Group Limited.
#
# Project: VSW5
#
# File: src/bin/pixval/blowup/Makefile
#
# Description:
#       Makefile for blowup utility
#
# Modifications:
# $Log: Makefile,v $
# Revision 1.1  2005-02-12 15:14:15  anderson
# Initial revision
#
# Revision 8.0  1998/12/23 23:25:19  mar
# Branch point for Release 5.0.2
#
# Revision 7.0  1998/10/30 22:43:33  mar
# Branch point for Release 5.0.2b1
#
# Revision 6.0  1998/03/02 05:17:40  tbr
# Branch point for Release 5.0.1
#
# Revision 5.0  1998/01/26 03:14:12  tbr
# Branch point for Release 5.0.1b1
#
# Revision 4.0  1995/12/15 08:44:30  tbr
# Branch point for Release 5.0.0
#
# Revision 3.1  1995/12/15  00:42:15  andy
# Prepare for GA Release
#

CFILES=ajax.c vblowup_c.c
OFILES=ajax.o vblowup_c.o
RM_FILES=*.o blowup core

blowup:	$(OFILES)
	$(CC) $(LDFLAGS) -o $@ $(OFILES) $(PORTLIB) $(SYSLIBS) $(SYSMATHLIB)

install: blowup
	$(CP) blowup $(XTESTBIN)

clean:
	$(RM) $(RM_FILES)

lint:
	$(LINT) $(LINTFLAGS) $(CFILES)

doc:
	ctodoc $(CFILES) > $$TET_ROOT/../doc/blowupraw.mm
