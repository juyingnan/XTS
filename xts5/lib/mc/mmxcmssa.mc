#
# Build a standalone version of the test case.
#
Test: $(OFILES) $(LIBS) ${XTESTLIBDIR}/libXR5.a $(TCM) $(AUXFILES)
	$(CC) $(LDFLAGS) -o $@ $(OFILES) $(TCM) $(LIBLOCAL) ${XTESTLIBDIR}/libXR5.a $(LIBS) $(SYSLIBS)

Test.c: $(SOURCES)
	$(CODEMAKER) -o Test.c $(SOURCES)

