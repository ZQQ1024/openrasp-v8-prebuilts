#!/bin/bash

set -e

# Compile catch2
echo "Compiling Catch2..."
cd catch2
mkdir -p build
cmake -B build -S . -DBUILD_TESTING=OFF -DCMAKE_INSTALL_PREFIX=build/Catch2
cmake --build build/ --target install
cd ..

mkdir -p artifacts/lib64 artifacts/include
cp -r catch2/build/Catch2/lib/* artifacts/lib64/
cp -r catch2/build/Catch2/include/ artifacts/include/

cd artifacts

echo "Compilation finished successfully."
