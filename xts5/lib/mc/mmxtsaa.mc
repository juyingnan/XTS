# $Header: /cvs/xtest/xtest/xts5/lib/mc/mmxtsaa.mc,v 1.1 2005-02-12 14:37:14 anderson Exp $ 
#
# Build a standalone version of the test case.
#
Test: $(OFILES) $(XT_LIBS) $(TCM) $(AUXFILES)
	$(CC) $(LDFLAGS) -o $@ $(OFILES) $(TCM) $(LIBLOCAL) $(XT_LIBS) $(XT_ATHENA) $(XT_SYSLIBS)

Test.c: $(SOURCES)
	$(CODEMAKER) -o Test.c $(SOURCES)

