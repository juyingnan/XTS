#
# Pixel generation makerules for generating the reference
# known good image files.
#

PVOFILES=pvtest.o

pvgen: $(PVOFILES) $(PVLIBS) $(top_builddir)/src/tet3/tcm/libtcmmain.la
	$(CC) $(LDFLAGS) -o $@ $(PVOFILES) $(top_builddir)/src/tet3/tcm/libtcmmain.la \
	$(PVLIBS) $(SYSLIBS) $(SYSMATHLIB)

pvtest.o: pvtest.c
	cc -c -DGENERATE_PIXMAPS $(CFLAGS) pvtest.c

pvtest.c: Test.c
	$(RM) pvtest.c; \
	$(LN) Test.c pvtest.c

