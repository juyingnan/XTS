include ../../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = $(XTS_LCFLAGS) $(XTS_CFLAGS)
LDADD = $(TCM) $(XTS_LLIBS) $(XTS_LIBS)

check_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:$(EXEEXT)=.c)
CLEANFILES = $(BUILT_SOURCES)

tprogs = \
	ChangeProperty/ChangeProperty \
	ConvertSelection/ConvertSelection \
	DeleteProperty/DeleteProperty \
	gtatmnm/gtatmnm \
	gtgmtry/gtgmtry \
	gtslctnown/gtslctnown \
	gtwdwattrb/gtwdwattrb \
	gtwdwprprt/gtwdwprprt \
	intrnatm/intrnatm \
	lstprprts/lstprprts \
	qrypntr/qrypntr \
	qrytr/qrytr \
	rttwdwprpr/rttwdwprpr \
	stslctnown/stslctnown \
	trnsltcrdn/trnsltcrdn
