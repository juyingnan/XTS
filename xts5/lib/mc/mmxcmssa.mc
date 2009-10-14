#
# Build a standalone version of the test case.
#
Test: $(OFILES) $(LIBS) ${XTESTLIBDIR}/libXR5.a $(top_builddir)/src/tet3/tcm/libtcmmain.la $(AUXFILES)
	$(CC) $(LDFLAGS) -o $@ $(OFILES) $(top_builddir)/src/tet3/tcm/libtcmmain.la $(LIBLOCAL) ${XTESTLIBDIR}/libXR5.a $(LIBS) $(SYSLIBS)

Test.c: $(SOURCES)
	$(CODEMAKER) -o Test.c $(SOURCES)

