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
# $Header: /cvs/xtest/xtest/xts5/src/libXtaw/Makefile,v 1.1 2005-02-12 15:14:15 anderson Exp $
#
# Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
# All Rights Reserved.
#
# Project: VSW5
#
# File: vsw5/src/lib/libXtaw/Makefile
#
# Description: Makefile for libXtaw
#
# Modifications
# $Log: Makefile,v $
# Revision 1.1  2005-02-12 15:14:15  anderson
# Initial revision
#
# Revision 8.0  1998/12/23 23:25:53  mar
# Branch point for Release 5.0.2
#
# Revision 7.0  1998/10/30 22:44:07  mar
# Branch point for Release 5.0.2b1
#
# Revision 6.0  1998/03/02 05:18:11  tbr
# Branch point for Release 5.0.1
#
# Revision 5.0  1998/01/26 03:14:43  tbr
# Branch point for Release 5.0.1b1
#
# Revision 4.0  1995/12/15 08:45:51  tbr
# Branch point for Release 5.0.0
#
# Revision 3.1  1995/12/15  00:44:01  andy
# Prepare for GA Release
#

.IGNORE:

CFILES =	AllWidgets.c \
		Box.c \
		Command.c \
		Form.c \
		Label.c \
		Paned.c \
		Tree.c \
		Viewport.c \
		Scrollbar.c \
		Grip.c \
		Sme.c \
		Simple.c \
		SmeBSB.c \
		SimpleMenu.c \
		XawInit.c

OFILES =	AllWidgets.o \
		Box.o \
		Command.o \
		Form.o \
		Label.o \
		Paned.o \
		Tree.o \
		Viewport.o \
		Scrollbar.o \
		Sme.o \
		SmeBSB.o \
		Simple.o \
		SimpleMenu.o \
		Grip.o \
		XawInit.o

RM_FILES = *.o core *.a

all: libXtaw.a 

libXtaw.a: $(OFILES)
		@$(AR) $@ `$(LORDER) $(OFILES) | $(TSORT)`
		: $(RANLIB) $@


.c.o:
	$(CC) -c $(CFLAGS) $<

install: all
	$(CP) libXtaw.a $(XTESTLIBDIR)
	@$(RANLIB) $(XTESTLIBDIR)/libXtaw.a

FORCE:		CLOBBER all

clean:
		@$(RM) -f $(RM_FILES)

clobber:	clean
