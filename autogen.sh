#! /bin/sh

srcdir=`dirname $0`
test -z "$srcdir" && srcdir=.

ORIGDIR=`pwd`
cd $srcdir

autoreconf -v --install || exit 1
cd $ORIGDIR || exit $?

sed -e 's/ac_default_prefix=\/usr\/local/ac_default_prefix=\/usr/g' ./configure > ./temp
mv ./temp ./configure
chmod +x ./configure

$srcdir/configure --enable-maintainer-mode "$@"
