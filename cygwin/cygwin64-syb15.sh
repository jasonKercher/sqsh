#!/bin/sh
#
# $Id: cygwin64-syb15.sh,v 1.1 2014/02/12 16:35:42 mwesdorp Exp $
# Shell script to build .a libraries from Sybase's .lib files.
# Original provided by Helmut Ruholl.
#

set +x
export SYBASE=/cygdrive/c/Sybase
export OCSLIB=${SYBASE}/${SYBASE_OCS}/lib
for i in libsybblk64 libsybcs64 libsybct64 ; do
    echo "EXPORTS" >${i}.def
    nm ${OCSLIB}/${i}.lib | grep 'T ' | grep -v "\.text" | sed 's/.* T //' >>${i}.def
    dlltool --dllname ${i}.dll --def ${i}.def --output-lib ${i}.a -k
done
rm -f *.def
