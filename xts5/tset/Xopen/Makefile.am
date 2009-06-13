include ../../common.mk

AM_CFLAGS = $(XTS_LCFLAGS) $(XTS_CFLAGS)
LDADD = $(TCM) $(XTS_LLIBS) $(XTS_LIBS)

check_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:$(EXEEXT)=.c)
CLEANFILES = $(BUILT_SOURCES)
.PHONY: $(TESTS)

tprogs = allcnmdclr/allcnmdclr
TESTS = xXAllocNamedColor

tprogs += crsrfnt/crsrfnt
TESTS += xcursorfont

tprogs += crtfntcrsr/crtfntcrsr
TESTS += xXCreateFontCursor

tprogs += kysym/kysym
TESTS += xkeysym

tprogs += kysymdf/kysymdf
TESTS += xkeysymdef

tprogs += kysymtkycd/kysymtkycd
TESTS += xXKeysymToKeycode

tprogs += lkpclr/lkpclr
TESTS += xXLookupColor

tprogs += strtkysym/strtkysym
TESTS += xXStringToKeysym

kysym_kysym_SOURCES = \
	kysym/kysym.c \
	kysym/Test0.c \
	kysym/Test1.c \
	kysym/Test2.c \
	kysym/Test3.c \
	kysym/Test4.c \
	kysym/TestG.c \
	kysym/TestM.c

kysymdf_kysymdf_SOURCES = \
	kysymdf/kysymdf.c \
	kysymdf/Test0.c \
	kysymdf/Test1.c \
	kysymdf/Test2.c \
	kysymdf/Test3.c \
	kysymdf/Test4.c \
	kysymdf/TestA.c \
	kysymdf/TestC.c \
	kysymdf/TestG.c \
	kysymdf/TestH.c \
	kysymdf/TestK.c \
	kysymdf/TestL.c \
	kysymdf/TestM.c \
	kysymdf/TestP.c \
	kysymdf/TestS.c \
	kysymdf/TestT.c

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

strtkysym_strtkysym_SOURCES = \
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
