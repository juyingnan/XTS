# $Header: /cvs/xtest/xtest/xts5/lib/mc/mmmlink.mc,v 1.1 2005-02-12 14:37:14 anderson Exp $ 
# A version of the test that can be combined with all the other tests for
# the macro version of the function.
#
mlink.c: $(SOURCES)
	$(CODEMAKER) -m -l -o mlink.c $(SOURCES)

linkexec:: m$(LINKEXEC) $(AUXFILES) ;

m$(LINKEXEC): ../Tests
	$(RM) m$(LINKEXEC)
	$(LN) ../Tests m$(LINKEXEC)
