all:
	mkdir bin lib lib/ksh lib/perl lib/tet3 lib/xpg3sh || true
	sh configure -t lite
	make -C src all install
	make -C xts5
