# $Header: /cvs/xtest/xtest/xts5/lib/mc/mmmisc.mc,v 1.1 2005-02-12 14:37:14 anderson Exp $ 
#
# Miscellaneous housekeeping functions.
#

# clean up and remove remakable sources, objects and junk files.
#
clean:
	@$(RM)  Test $(OFILES) $(LOFILES) $(LINKOBJ) $(LINKEXEC) core*\
		MTest m$(LINKEXEC) $(MOFILES) CONFIG Makefile.bak $(AUXCLEAN)\
		MTest.c Test.c mlink.c link.c Makefile *.err

# clobber - aka clean.
#
clobber:	clean

# Lint makerules
#
lint: $(CFILES)
	$(LINT) $(LINTFLAGS) $(CFILES) $(LINTTCM) $(LINTLIBS)

LINT:lint

