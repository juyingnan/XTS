AM_CPPFLAGS=-DTET_LITE
bin_PROGRAMS = tcc
tcc_CFLAGS = -I ../inc -I $(top_srcdir)/include
# Note: the order of these is important
tcc_LDADD = ../tcm/libapi.a ../apilib/libapi.a ../tcclib/libapi.a ../dtet2lib/libapi.a
tcc_SOURCES = cleanup.c \
		config.c \
		copysave.c \
		dirtab.c \
		dtcc.c \
		environ.c \
		error.c \
		exec.c \
		fake.c \
		global.c \
		jnlproc.c \
		journal.c \
		keys.c \
		lock.c \
		procdir.c \
		proctab.c \
		proctc.c \
		proctcd.c \
		rescode.c \
		resdir.c \
		rrproc.c \
		scen1.c \
		scen2.c \
		scen3.c \
		scenario.c \
		scentab.c \
		service.c \
		sigtrap.c \
		syscall.c \
		systab.c \
		tcc.c \
		tcname.c \
		tool.c \
		utils.c \
		ynstr.c

# These didn't get compiled before the autotools conversion.
#		fake_in.c 
#		fake_xt.c
#		scenpp.c 
#		tcc_bs.c 
#		tcc_in.c
#		tcc_xt.c 
