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
# Copyright (c) Applied Testing and Technology, Inc. 1993, 1994, 1995
# All Rights Reserved.
#
# Project: VSW5
#
# File: xts5/src/bin/reports/Makefile
#
# Description:
#	Makefile for report generators
#
# Modifications:
# $Log: Makefile,v $
# Revision 1.2  2005-11-03 08:42:01  jmichael
# clean up all vsw5 paths to use xts5 instead.
#
# Revision 1.1.1.1  2005/02/12 15:14:15  anderson
# VSW5 Source under an MIT license This is version 5.0.2 as received from
# AppTest with the new license applied.
#
# Revision 8.0  1998/12/23 23:24:18  mar
# Branch point for Release 5.0.2
#
# Revision 7.0  1998/10/30 22:42:28  mar
# Branch point for Release 5.0.2b1
#
# Revision 6.0  1998/03/02 05:16:44  tbr
# Branch point for Release 5.0.1
#
# Revision 5.0  1998/01/26 03:13:17  tbr
# Branch point for Release 5.0.1b1
#
# Revision 4.3  1996/07/10 01:07:58  andy
# Changed mreport to vswrptm
#
# Revision 4.2  1996/07/09  23:57:57  andy
# Changed creport to vswrpt
#
# Revision 4.1  1996/03/22  16:49:40  andy
# Removed trailing smei-colons from target lines
#
# Revision 4.0  1995/12/15  08:41:30  tbr
# Branch point for Release 5.0.0
#
# Revision 3.2  1995/12/15  00:38:25  andy
# Prepare for GA Release
#

all:	vswrpt vswrptm vsw_pr

vswrpt: vswrpt.c
	$(CC) $(CFLAGS) -o vswrpt vswrpt.c $(LDFLAGS) $(SYSLIBS)

vswrptm: vswrptm.c
	$(CC) $(CFLAGS) -o vswrptm vswrptm.c $(LDFLAGS) $(SYSLIBS)

vsw_pr: vsw_pr.c
	$(CC) $(CFLAGS) -o vsw_pr vsw_pr.c $(LDFLAGS) $(SYSLIBS)

clean:
	@rm -f *.o
	@rm -f vswrpt vswrptm vsw_pr

clobber: clean
	@rm -f $(TET_ROOT)/xts5/bin/vswrpt
	@rm -f $(TET_ROOT)/xts5/bin/vswrptm
	@rm -f $(TET_ROOT)/xts5/bin/vsw_pr

install: all
	@(cp $(TET_ROOT)/xts5/src/bin/reports/vswrpt $(TET_ROOT)/xts5/bin)
	@(cp $(TET_ROOT)/xts5/src/bin/reports/vswrptm $(TET_ROOT)/xts5/bin)
	@(cp $(TET_ROOT)/xts5/src/bin/reports/vsw_pr $(TET_ROOT)/xts5/bin)
