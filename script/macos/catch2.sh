#!/bin/bash

set -e

# Compile catch2
echo "Compiling Catch2..."
cd catch2
mkdir -p build
cmake -B build -S . -DBUILD_TESTING=OFF -DCMAKE_INSTALL_PREFIX=build/prefix
cmake --build build/ --target install
cd ..

mkdir -p artifacts/lib64 artifacts/include
cp -r catch2/build/prefix/lib/* artifacts/lib64/
cp -r catch2/build/prefix/include/ artifacts/include/

cd artifacts
ln -s lib64 lib

echo "Compilation finished successfully."
