# $Header: /cvs/xtest/xtest/xts5/lib/mc/mmxtlib.mc,v 1.1 2005-02-12 14:37:14 anderson Exp $ 
# 
# This part of the makefile checks for the existance of the libraries
# and creates them if necessary.
#

# The xtestlib library is made if it doesn't exist
#
$(XTESTLIB):
	cd $(XTESTROOT)/src/lib; $(TET_BUILD_TOOL) install

# The libXtTest library is made if it doesn't exist
#
${XTESTLIBDIR}/libXtTest.a:
	cd $(XTESTROOT)/src/libXtTest; $(TET_BUILD_TOOL) install

