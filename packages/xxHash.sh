#!/bin/bash
## INFO ##
## INFO ##

DIR="$1";
TMP="$2";
CC="$3";
CFLAGS="-std=c11 -O3 -march=native";

include="$4";
library="$5";
build_dir="$TMP/build";
binary_dir="$TMP/bin";
library_dir="$TMP/lib";

# Stop on error
set -e;

# Import 'run' and 'sudorun' functions
source "utils.sh"

# Build and install
run "Create temporary directories" \
    "mkdir -p $build_dir $library_dir";

run "Compile source to object" \
    "$CC $CFLAGS -I$DIR -fPIC -c -o $build_dir/xxhash.o $DIR/xxhash.c";

run "Build shared library" \
    "$CC -shared -o $library_dir/libxxhash.so $build_dir/xxhash.o";

run "Build static library" \
    "ar rcs $library_dir/libxxhash.a $build_dir/xxhash.o";

sudorun "Install header files" \
        "cp -f $DIR/xxhash.h $include";

sudorun "Install library files" \
        "cp -f $library_dir/libxxhash.* $library";
