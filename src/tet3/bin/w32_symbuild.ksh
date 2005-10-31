#
#	SCCS: @(#)w32_symbuild.ksh	1.1 (98/09/01)
#
#	UniSoft Ltd., London, England
#
# Copyright (c) 1998 The Open Group
# All rights reserved.
#
# No part of this source code may be reproduced, stored in a retrieval
# system, or transmitted, in any form or by any means, electronic,
# mechanical, photocopying, recording or otherwise, except as stated in
# the end-user licence agreement, without the prior permission of the
# copyright owners.
# A copy of the end-user licence agreement is contained in the file
# Licence which accompanies this distribution.
# 
# Motif, OSF/1, UNIX and the "X" device are registered trademarks and
# IT DialTone and The Open Group are trademarks of The Open Group in
# the US and other countries.
#
# X/Open is a trademark of X/Open Company Limited in the UK and other
# countries.
#
# ************************************************************************
#
# SCCS:   	@(#)w32_symbuild.ksh	1.1 98/09/01 TETware release 3.3
# NAME:		w32_symbuild.ksh
# PRODUCT:	TETware
# AUTHOR:	Andrew Dingwall, UniSoft Ltd.
# DATE CREATED:	July 1998
#
# DESCRIPTION:
#	shell script to extract the imported and exported symbols
#	from a .c file, then compile the .c file so that a reference
#	to a symbol that is exported from a program to a DLL is changed
#	to an indirect reference via a pointer
#	
#
# MODIFICATIONS:
# 
# ************************************************************************

# determine the name of the .c file
cfile=
for arg
do
	case $arg in
	*.c)
		if test -z "$cfile"
		then
			cfile=$arg
		else
			echo $0: can only handle one .c file 1>&2
			exit 2
		fi
		;;
	esac
done

if test -z "$cfile"
then
	echo $0: need a .c file name 1>&2
	exit 2
fi

# extract the symbols
CC=${CC:?} sh ../bin/symbols.sh "$@"

# for each symbol that is exported from a program to a DLL, a cdef is
# generated of the form:
#
#	-Dfoo=(*tet_dll_foo)
#
x=${cfile##*/}
symfile=${x%.c}.sym
cdefs=
while read impexp type name junk
do
	case $impexp in
	EXPORT)
		cdefs="$cdefs${cdefs:+ }-D$name=(*tet_dll_$name)"
		;;
	esac
done < $symfile


# do the compilation
echo $CC $cdefs "$@"
$CC $cdefs "$@"

