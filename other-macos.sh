#!/bin/bash

# Exit if any command fails
set -e

PREFIX=$HOME/libs

# Compile cpr
echo "Compiling CPR..."
cd cpr
mkdir -p build
cd build
cmake .. -DBUILD_SHARED_LIBS=OFF
cmake --build .
cd ../..

mkdir -p artifacts/lib64 artifacts/include
cp cpr/build/lib/libcpr.a artifacts/lib64/
cp -r cpr/include/ artifacts/include/

cd artifacts
ln -s lib64 lib

echo "Compilation finished successfully."
