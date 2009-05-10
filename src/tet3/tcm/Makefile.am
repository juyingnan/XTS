AM_CPPFLAGS = -I../inc -I$(top_srcdir)/include -DTET_LITE
noinst_LTLIBRARIES = libtcm.la libtcmmain.la libtcmchild.la
libtcm_la_SOURCES = child.c \
			ckversion.c \
			dynlink.c \
			ictp.c \
			tcmfuncs.c

# When linking to either of these libraries, remember to link libapi.la
# after them
libtcmmain_la_SOURCES = tcm.c dtcm.c
libtcmchild_la_SOURCES = tcmchild.c

# These didn't get compiled before the autotools conversion
#			tcm_bs.c 
#			tcm_in.c 
#			tcmrem.c 
#			tcm_xt.c
