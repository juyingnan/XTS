AM_CPPFLAGS = -I$(srcdir)/../inc -I$(top_srcdir)/include \
	-DDEFAULT_TET_ROOT='"$(DEFAULT_TET_ROOT)"' \
	-DDEFAULT_TET_EXEC_ROOT='"$(DEFAULT_TET_EXEC_ROOT)"'
bin_PROGRAMS = tcc
tcc_LDADD = ../tcclib/libtcc.la
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
		ynstr.c \
		dirtab.h \
		dtcc.h \
		keys.h \
		proctab.h \
		scentab.h \
		systab.h \
		tcc.h

# These didn't get compiled before the autotools conversion.
#		fake_in.c 
#		fake_xt.c
#		scenpp.c 
#		tcc_bs.c 
#		tcc_in.c
#		tcc_xt.c 
