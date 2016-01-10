#!/bin/bash
## INFO ##
## INFO ##

# Constants
PACKAGES="xxHash";

# Variables
update=0;
packages="";
compiler="gcc";
binary="/usr/local/bin";
share="/usr/local/share";
library="/usr/local/lib";
include="/usr/local/include";

# Stop if any error occurs
set -e;

# Parse passed commands
while [ -n "$1" ];
do
    case "$1" in
        # Specify C compiler
        -c|--compiler)
            shift;
            compiler="$1";;
        # Specify header install destination
        -i|--include)
            shift;
            include="$1";;
        # Specify library install destination
        -l|--library)
            shift;
            library="$1";;
        # Specify binary install destination
        -b|--binary)
            shift;
            include="$1";;
        # Specify share install destination
        -s|--share)
            shift;
            include="$1";;
        # Specify package to build and install
        -p|--package)
            shift;
            packages="$packages $1";;
        # Update all packages (pull from git repo)
        -u|--update)
            update=1;;
        # Unknown argument passed
        *)
            printf "Unknown argument: '$1'\n";
            exit 1;;
    esac;
    shift;
done;

# If packages should be updated
if [ "$update" -gt "0" ];
then
    git submodule update --remote --merge;
    exit 0;
fi;

# If no packages defined by the user, use all packages
if [ -z "$packages" ];
then
    packages="$PACKAGES";
fi;

# Build and install packages
for package in "$packages";
do
    tmpdir="packages/tmp/$package";
    rm -rf "$tmpdir";
    mkdir -p "$tmpdir";
    bash "packages/$package.sh" \
         "packages/$package"    \
         $tmpdir                \
         $compiler              \
         $include               \
         $library               \
         $binary                \
         $share;
done;

exit 0;
