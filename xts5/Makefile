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
# $Header: /cvs/xtest/xtest/xts5/Makefile,v 1.4 2005-11-01 00:41:26 jamey Exp $
#
# Copyright (c) Applied Testing and Technology, Inc. 1995
# All Rights Reserved.
#
# Project:     VSW5
#
# File:        Makefile
#
# Description:
#       Master makefile for installing VSW5
#
# Modifications:
# $Log: Makefile,v $
# Revision 1.4  2005-11-01 00:41:26  jamey
# Copy tetbuild.cfg from the configs directory if possible and needed; cvsignore output from make build.
#
# Revision 1.3  2005/04/19 05:13:34  anderson
# Add a step to ensure the wbuild scrpt is executable
#
# Revision 1.2  2005/02/12 16:50:15  anderson
# Build the local version of libXaw & Xmu to make all of this stand-alone
#
# Revision 1.1.1.1  2005/02/12 15:14:15  anderson
# VSW5 Source under an MIT license This is version 5.0.2 as received from
# AppTest with the new license applied.
#
# Revision 8.0  1998/12/23 23:39:33  mar
# Branch point for Release 5.0.2
#
# Revision 7.0  1998/10/30 23:02:41  mar
# Branch point for Release 5.0.2b1
#
# Revision 6.0  1998/03/02 05:30:33  tbr
# Branch point for Release 5.0.1
#
# Revision 5.0  1998/01/26 03:27:07  tbr
# Branch point for Release 5.0.1b1
#
# Revision 4.1  1998/01/12 21:36:08  andy
# Changed bin/creport to bin/reports
#
# Revision 4.0  1995/12/15 09:25:50  tbr
# Branch point for Release 5.0.0
#
# Revision 3.2  1995/12/15  00:32:44  andy
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
# 

#
# For full details on what needs to be built and how to build, refer
# to the User Guide.
#
# First, work through the instructions in the section entitled 
# "INSTALLING VSW5" in the User's Guide. This involves 
# setting the configuration parameters correctly for your system.
#
# Ensure your PATH environment variable is set to include $TET_ROOT/xts5/bin.
#
# Then, just type "make" in this directory:
#
# You then need to build and install the test fonts as described in the 
# User's Guide.
#

.IGNORE:

all: build install

build: tetbuild.cfg
	chmod ugo+x bin/wbuild
	@if [ -s $(TET_ROOT)/vsw5/results/install.log ]; \
	then \
	mv -f $(TET_ROOT)/vsw5/results/install.log $(TET_ROOT)/vsw5/results/install.log.o; \
	fi
	@(echo VSW5 INSTALLATION LOG|tee -a $(TET_ROOT)/vsw5/results/install.log)
	@(echo |tee -a $(TET_ROOT)/vsw5/results/install.log)
	@(date |tee -a $(TET_ROOT)/vsw5/results/install.log)
	@(uname -a |tee -a $(TET_ROOT)/vsw5/results/install.log)
	@(id |tee -a $(TET_ROOT)/vsw5/results/install.log)
	@(echo |tee -a $(TET_ROOT)/vsw5/results/install.log)
	@(echo Building libxtest |tee -a $(TET_ROOT)/vsw5/results/install.log)
	@(cd $(TET_ROOT)/vsw5/src/lib; wbuild install 2>&1 | tee -a $(TET_ROOT)/vsw5/results/install.log)
	@(echo Building libXst |tee -a $(TET_ROOT)/vsw5/results/install.log)
	@(cd $(TET_ROOT)/vsw5/src/libproto; wbuild install 2>&1 | tee -a $(TET_ROOT)/vsw5/results/install.log)
	@(echo Building libximtest |tee -a $(TET_ROOT)/vsw5/results/install.log)
	@(cd $(TET_ROOT)/vsw5/src/xim; wbuild install 2>&1 | tee -a $(TET_ROOT)/vsw5/results/install.log)
	@(echo Building libfonts |tee -a $(TET_ROOT)/vsw5/results/install.log)
	@(cd $(TET_ROOT)/vsw5/fonts; wbuild install 2>&1 | tee -a $(TET_ROOT)/vsw5/results/install.log)
	@(echo Building libXR5 |tee -a $(TET_ROOT)/vsw5/results/install.log)
	@(cd $(TET_ROOT)/vsw5/src/libXR5; wbuild install 2>&1 | tee -a $(TET_ROOT)/vsw5/results/install.log)
	@(echo Building libXtaw |tee -a $(TET_ROOT)/vsw5/results/install.log)
	@(cd $(TET_ROOT)/vsw5/src/libXtaw; wbuild install 2>&1 | tee -a $(TET_ROOT)/vsw5/results/install.log)
	@(echo Building libXtmu |tee -a $(TET_ROOT)/vsw5/results/install.log)
	@(cd $(TET_ROOT)/vsw5/src/libXtmu; wbuild install 2>&1 | tee -a $(TET_ROOT)/vsw5/results/install.log)
#not included in the Lite version
	@if [ -d $(TET_ROOT)/vsw5/src/libXtTest ]; \
	then \
	echo Building libXtTest |tee -a $(TET_ROOT)/vsw5/results/install.log; \
	cd $(TET_ROOT)/vsw5/src/libXtTest; wbuild install 2>&1 | tee -a $(TET_ROOT)/vsw5/results/install.log; \
	fi
	@(echo Building mc utility |tee -a $(TET_ROOT)/vsw5/results/install.log)
	@(cd $(TET_ROOT)/vsw5/src/bin/mc; wbuild install 2>&1 | tee -a $(TET_ROOT)/vsw5/results/install.log)
	@(echo Building report generators |tee -a $(TET_ROOT)/vsw5/results/install.log)
	@(cd $(TET_ROOT)/vsw5/src/bin/reports; wbuild install 2>&1 | tee -a $(TET_ROOT)/vsw5/results/install.log)
	@(echo Building blowup utility |tee -a $(TET_ROOT)/vsw5/results/install.log)
	@(cd $(TET_ROOT)/vsw5/src/pixval/blowup; wbuild install 2>&1 | tee -a $(TET_ROOT)/vsw5/results/install.log)
	@(echo |tee -a $(TET_ROOT)/vsw5/results/install.log)

tetbuild.cfg:
	cp configs/tetbuild.cfg.`uname` tetbuild.cfg

install:
	@(echo Setting 775 directory permissions |tee -a $(TET_ROOT)/vsw5/results/install.log)
	@(find . -type d -print | xargs chmod 775)
	@(echo INSTALLATION OF LIBRARIES AND TOOLS COMPLETED |tee -a $(TET_ROOT)/vsw5/results/install.log)
	@(echo FONTS MUST ALSO BE INSTALLED BEFORE RUNNING TESTS |tee -a $(TET_ROOT)/vsw5/results/install.log)

athena:
	@(echo Building VSW Xaw and Xmu libraries |tee -a $(TET_ROOT)/vsw5/results/install.log)
	@(cd $(TET_ROOT)/vsw5/src/libXtaw; wbuild install 2>&1 | tee -a $(TET_ROOT)/vsw5/results/install.log)
	@(cd $(TET_ROOT)/vsw5/src/libXtmu; wbuild install 2>&1 | tee -a $(TET_ROOT)/vsw5/results/install.log)

clean:
	@(cd src/lib; wclean)
	@(cd src/libXR5; wclean)
	@if [ -d $(TET_ROOT)/vsw5/src/libXtTest ]; \
	then \
	cd src/libXtTest; wclean; \
	fi
	@(cd src/libproto; wclean)
	@(cd src/libXtaw; wclean)
	@(cd src/libXtmu; wclean)
	@(cd src/xim; wclean)
	@(cd fonts; wclean)
	@(cd src/bin/mc ; wclean)
	@(cd src/bin/reports ; wclean)
	@(cd src/pixval/blowup; wclean)
