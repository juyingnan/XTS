# $Header: /cvs/xtest/xtest/xts5/lib/mc/mmpgen.mc,v 1.1 2005-02-12 14:37:14 anderson Exp $ 
#
# Pixel generation makerules for generating the reference
# known good image files.
#

PVOFILES=pvtest.o

pvgen: $(PVOFILES) $(PVLIBS) $(TCM)
	$(CC) $(LDFLAGS) -o $@ $(PVOFILES) $(TCM) \
	$(PVLIBS) $(SYSLIBS) $(SYSMATHLIB)

pvtest.o: pvtest.c
	cc -c -DGENERATE_PIXMAPS $(CFLAGS) pvtest.c

pvtest.c: Test.c
	$(RM) pvtest.c; \
	$(LN) Test.c pvtest.c

