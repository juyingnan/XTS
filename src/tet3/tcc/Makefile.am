bin_PROGRAMS = tcc
tcc_CFLAGS = -I ../inc -I $(top_srcdir)/include
tcc_LDADD = ../tcm/libapi.a ../apilib/libapi.a ../dtet2lib/libapi.a ../tcclib/libtcc.a ../servlib/libapi.a ../inetlib/libapi.a
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

# Not sure about these ones - maybe if LITE isn't defined?

#		tcc_in.c 
#		fake_in.c 
#		fake_xt.c
#		scenpp.c 
#		tcc_bs.c 
#		tcc_xt.c 
