include ../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = $(XTS_LCFLAGS) $(XTS_CFLAGS)
LDADD = $(TCM) $(XTS_LLIBS) $(XTS_LIBS)

libexec_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:$(EXEEXT)=.c)
CLEANFILES = $(BUILT_SOURCES)

tprogs = \
	XAllocNamedColor/XAllocNamedColor \
	cursorfont/cursorfont \
	XCreateFontCursor/XCreateFontCursor \
	keysym/keysym \
	keysymdef/keysymdef \
	XKeysymToKeycode/XKeysymToKeycode \
	XLookupColor/XLookupColor \
	XStringToKeysym/XStringToKeysym

keysym_keysym_SOURCES = \
	keysym/keysym.c \
	keysym/Test0.c \
	keysym/Test1.c \
	keysym/Test2.c \
	keysym/Test3.c \
	keysym/Test4.c \
	keysym/TestG.c \
	keysym/TestM.c

keysymdef_keysymdef_SOURCES = \
	keysymdef/keysymdef.c \
	keysymdef/Test0.c \
	keysymdef/Test1.c \
	keysymdef/Test2.c \
	keysymdef/Test3.c \
	keysymdef/Test4.c \
	keysymdef/TestA.c \
	keysymdef/TestC.c \
	keysymdef/TestG.c \
	keysymdef/TestH.c \
	keysymdef/TestK.c \
	keysymdef/TestL.c \
	keysymdef/TestM.c \
	keysymdef/TestP.c \
	keysymdef/TestS.c \
	keysymdef/TestT.c

XKeysymToKeycode_XKeysymToKeycode_SOURCES = \
	XKeysymToKeycode/XKeysymToKeycode.c \
	XKeysymToKeycode/Test1.c \
	XKeysymToKeycode/Test2.c \
	XKeysymToKeycode/Test3.c \
	XKeysymToKeycode/Test4.c \
	XKeysymToKeycode/TestA.c \
	XKeysymToKeycode/TestC.c \
	XKeysymToKeycode/TestG.c \
	XKeysymToKeycode/TestH.c \
	XKeysymToKeycode/TestK.c \
	XKeysymToKeycode/TestL.c \
	XKeysymToKeycode/TestM.c \
	XKeysymToKeycode/TestP.c \
	XKeysymToKeycode/TestS.c \
	XKeysymToKeycode/TestT.c

XStringToKeysym_XStringToKeysym_SOURCES = \
	XStringToKeysym/XStringToKeysym.c \
	XStringToKeysym/Test1.c \
	XStringToKeysym/Test2.c \
	XStringToKeysym/Test3.c \
	XStringToKeysym/Test4.c \
	XStringToKeysym/TestA.c \
	XStringToKeysym/TestC.c \
	XStringToKeysym/TestG.c \
	XStringToKeysym/TestH.c \
	XStringToKeysym/TestK.c \
	XStringToKeysym/TestL.c \
	XStringToKeysym/TestM.c \
	XStringToKeysym/TestP.c \
	XStringToKeysym/TestS.c \
	XStringToKeysym/TestT.c
