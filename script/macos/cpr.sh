#!/bin/bash

set -e

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

echo "Compilation finished successfully."
