# https://github.com/tbossi/v8-builder

VERSION=$1

git config --global user.name "V8 macOS Builder"
git config --global user.email "v8.macos.builder@localhost"
git config --global core.autocrlf false
git config --global core.filemode false
git config --global color.ui true


cd ~
echo "=====[ Getting Depot Tools ]====="	
git clone -q https://chromium.googlesource.com/chromium/tools/depot_tools.git
export PATH=$(pwd)/depot_tools:$PATH
gclient

echo "=====[ Fetching V8 ]====="
fetch v8
echo "target_os = ['mac']" >> .gclient
cd ~/v8
git checkout $VERSION
gclient sync


echo "=====[ Building V8 ]====="
python2 ./tools/dev/v8gen.py arm64.release -vv -- '
target_os = "mac"
target_cpu = "arm64"
is_debug = false
symbol_level = 0
is_component_build = false
treat_warnings_as_errors = false
libcxx_abi_unstable = false
v8_embedder_string = " <OpenRASP>"
v8_monolithic = true
v8_enable_i18n_support = false
v8_use_snapshot = true
v8_use_external_startup_data = false
v8_enable_shared_ro_heap = true
use_custom_libcxx = false
'

ninja -C out.gn/arm64.release -t clean
ninja -C out.gn/arm64.release v8

mkdir -p output/arm64

cp -r v8/include output/include

cp v8/out/arm64.release/obj/libv8_monolith.a output/arm64/libv8_monolith.a