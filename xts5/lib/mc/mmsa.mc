# $Header: /cvs/xtest/xtest/xts5/lib/mc/mmsa.mc,v 1.1 2005-02-12 14:37:14 anderson Exp $ 
#
# Build a standalone version of the test case.
#
Test: $(OFILES) $(LIBS) $(TCM) $(AUXFILES)
	$(CC) $(LDFLAGS) -o $@ $(OFILES) $(TCM) $(LIBLOCAL) $(LIBS) $(SYSLIBS)

Test.c: $(SOURCES)
	$(CODEMAKER) -o Test.c $(SOURCES)

