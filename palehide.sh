#! /bin/sh
set -e
set -x

basepath=$(dirname "$0")

if [ $(uname -s) = "Darwin" ]; then
    xattr -c "$basepath"/palera1n-macos-universal
    chmod 755 "$basepath"/palera1n-macos-universal
    "$basepath"/palera1n-macos-universal -l -k "$basepath"/roothide/Pongo.bin -K "$basepath"/roothide/checkra1n-kpf-pongo -o "$basepath"/roothide/jbinit
else
    chmod 755 "$basepath"/palera1n-linux-x86_64
    sudo "$basepath"/palera1n-linux-x86_64 -l -k "$basepath"/roothide/Pongo.bin -K "$basepath"/roothide/checkra1n-kpf-pongo -o "$basepath"/roothide/jbinit
fi
