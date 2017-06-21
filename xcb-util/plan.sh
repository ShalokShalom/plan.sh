pkg_origin=cosmos
pkg_name=xcb-util
pkg_version=0.4.0
pkg_description="Utility libraries for XC Binding"
pkg_upstream_url="http://xcb.freedesktop.org"
pkg_license=("custom")
pkg_deps=("cosmos/libxcb" "xorg/libXdmcp" "xorg/libXau" "xorg/xproto")
pkg_build_deps=("cosmos/gperf" "cosmos/util-macros" "core/gcc" "core/make" "core/pkg-config" "xorg/libpthread-stubs"  )
pkg_shasum=("46e49469cb3b594af1d33176cd7565def2be3fa8be4371d62271fabb5eae50e9")
pkg_source=("http://xcb.freedesktop.org/dist/${pkg_name}-${pkg_version}.tar.bz2")
