include ../../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = $(XTS_LCFLAGS) $(XTS_CFLAGS)
LDADD = $(TCM) $(XTS_LLIBS) $(XTS_LIBS)

check_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:$(EXEEXT)=.c)
CLEANFILES = $(BUILT_SOURCES)

tprogs = \
	XAllocNamedColor/XAllocNamedColor \
	cursorfont/cursorfont \
	XCreateFontCursor/XCreateFontCursor \
	keysym/keysym \
	keysymdef/keysymdef \
	kysymtkycd/kysymtkycd \
	LookupColor/LookupColor \
	strtkysym/strtkysym

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

kysymtkycd_kysymtkycd_SOURCES = \
	kysymtkycd/kysymtkycd.c \
	kysymtkycd/Test1.c \
	kysymtkycd/Test2.c \
	kysymtkycd/Test3.c \
	kysymtkycd/Test4.c \
	kysymtkycd/TestA.c \
	kysymtkycd/TestC.c \
	kysymtkycd/TestG.c \
	kysymtkycd/TestH.c \
	kysymtkycd/TestK.c \
	kysymtkycd/TestL.c \
	kysymtkycd/TestM.c \
	kysymtkycd/TestP.c \
	kysymtkycd/TestS.c \
	kysymtkycd/TestT.c

strtkeysym_strtkeysym_SOURCES = \
	strtkysym/strtkysym.c \
	strtkysym/Test1.c \
	strtkysym/Test2.c \
	strtkysym/Test3.c \
	strtkysym/Test4.c \
	strtkysym/TestA.c \
	strtkysym/TestC.c \
	strtkysym/TestG.c \
	strtkysym/TestH.c \
	strtkysym/TestK.c \
	strtkysym/TestL.c \
	strtkysym/TestM.c \
	strtkysym/TestP.c \
	strtkysym/TestS.c \
	strtkysym/TestT.c
