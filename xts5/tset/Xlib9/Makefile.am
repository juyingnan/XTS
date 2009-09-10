include ../../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = $(XTS_LCFLAGS) $(XTS_CFLAGS)
LDADD = $(TCM) $(XTS_LLIBS) $(XTS_LIBS)

check_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:$(EXEEXT)=.c)
CLEANFILES = $(BUILT_SOURCES)

tprogs = \
	ClearArea/ClearArea \
	clrwdw/clrwdw \
	CopyArea/CopyArea \
	CopyPlane/CopyPlane \
	drwarc/drwarc \
	drwarcs/drwarcs \
	drwimgst16/drwimgst16 \
	drwimgstr/drwimgstr \
	drwln/drwln \
	drwlns/drwlns \
	drwpnt/drwpnt \
	drwpnts/drwpnts \
	drwrctngl/drwrctngl \
	drwrctngls/drwrctngls \
	drwsgmnts/drwsgmnts \
	drwstr/drwstr \
	drwstr16/drwstr16 \
	drwtxt/drwtxt \
	drwtxt16/drwtxt16 \
	fllarc/fllarc \
	fllarcs/fllarcs \
	fllplygn/fllplygn \
	fllrctngl/fllrctngl \
	fllrctngls/fllrctngls \
	frfnt/frfnt \
	frfntinf/frfntinf \
	frfntnms/frfntnms \
	frfntpth/frfntpth \
	gtfntprprt/gtfntprprt \
	GetFontPath/GetFontPath \
	gtimg/gtimg \
	gtsbimg/gtsbimg \
	ldfnt/ldfnt \
	ldqryfnt/ldqryfnt \
	lstfnts/lstfnts \
	lstfntswth/lstfntswth \
	ptimg/ptimg \
	qryfnt/qryfnt \
	qrytxtex16/qrytxtex16 \
	qrytxtextn/qrytxtextn \
	stfntpth/stfntpth \
	txtextnt16/txtextnt16 \
	txtextnts/txtextnts \
	txtwdth/txtwdth \
	txtwdth16/txtwdth16 \
	unldfnt/unldfnt
