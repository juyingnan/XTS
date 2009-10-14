#
# Build a standalone version of the test case using the macro version
# of the function.
#
MTest: $(MOFILES) $(LIBS) $(top_builddir)/src/tet3/tcm/libtcmmain.la $(AUXFILES)
	$(CC) $(LDFLAGS) -o $@ $(MOFILES) $(top_builddir)/src/tet3/tcm/libtcmmain.la $(LIBLOCAL) $(LIBS) $(SYSLIBS)

MTest.c: $(SOURCES)
	$(CODEMAKER) -m -o MTest.c $(SOURCES)

