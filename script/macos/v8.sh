# https://github.com/tbossi/v8-builder

VERSION=$1

cd ~
echo "=====[ Getting Depot Tools ]====="	
git clone -q https://chromium.googlesource.com/chromium/tools/depot_tools.git
export PATH=$(pwd)/depot_tools:$PATH
gclient

echo "=====[ Fetching V8 ]====="
fetch v8
cd ~/v8
git checkout $VERSION
gclient sync

mkdir -p out/monolith.macos

echo "=====[ Building V8 ]====="
cat > out/monolith.macos/args.gn <<EOF
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
EOF

gn gen out/monolith.macos
ninja -C out/monolith.macos -j 8 v8_monolith

cd ~

mkdir -p output/macos

cp -r v8/include output/include

cp v8/out/monolith.macos/obj/libv8_monolith.a output/macos/libv8_monolith.a