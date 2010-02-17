include ../../common.mk

# XP_OPEN_DIS - A choice of which code to build in the X Protocol library
# to make an X server connection.
# This must be set to one of three possible values:
#
#	XlibXtst.c	Your Xlib includes enhancements to _XConnectDisplay
#			ensuring maximum portable protocol test coverage.
#	XlibOpaque.c	You have a normal R4 Xlib or early R5 Xlib which you
#			cannot patch to include the enhancements to
#			_XConnectDisplay, and you cannot emulate these by
#			building XlibNoXtst.c, so only client-native testing
#			can be done portably, and no failure testing of
#			XOpenDisplay can be done.
#			This option uses XOpenDisplay to make the connection,
#			from which the file descriptor is recovered for
#			our own use. XCloseDisplay shuts down the connection.
#	XlibNoXtst.c	As for XlibOpaque.c but you can use the R4/R5
#			connection emulation supplied. (Note: R4/R5 independent)
#			This will ensure maximum protocol test coverage
#			but may not be portable to all platforms.
#
# Reasons for not being able to build XlibNoXtst.c might include:
# i)  different interfaces to connection setup and connection read/write;
# ii) different access control mechanisms.
# Refer to your Xlib documentation for further details.
#
XP_OPEN_DIS=XlibXtst.c
#XP_OPEN_DIS=XlibNoXtst.c
#XP_OPEN_DIS=XlibOpaque.c

AM_CFLAGS = -I$(top_srcdir)/include \
	-I$(top_srcdir)/src/tet3/inc \
	-I$(top_srcdir)/xts5/include \
	$(XTS_CFLAGS)
noinst_LTLIBRARIES = libXst.la
libXst_la_SOURCES =\
	XstlibInt.h\
	XstosInt.h\
	DataMove.h\
	ShowReq.c\
	ShowExtReq.c\
	SendReq.c\
	SendXIReq.c\
	SendEvt.c\
	ShowRep.c\
	ShowExtRep.c\
	MakeReq.c\
	MakeXIReq.c\
	RcvRep.c\
	RcvExtRep.c\
	RcvEvt.c\
	RcvExtEvt.c\
	RcvErr.c\
	RcvExtErr.c\
	ShowEvt.c\
	ShowExtEvt.c\
	ShowErr.c\
	ShowExtErr.c\
	DfltVals.c\
	ResMng.c\
	Log.c\
	ClientMng.c\
	ConnDis.c \
	x11_trans.c \
	Expect.c\
	$(XP_OPEN_DIS)\
	ValListMng.c\
	Timer.c\
	XstIO.c\
	DataMove.c\
	TestMng.c\
	Utils.c\
	SendSup.c\
	ShowSup.c\
	TestSup.c\
	Validate.c\
	tpstartup.c\
	startup.c\
	delete.c
