pkg_name=dpkg
pkg_origin=core
pkg_version=1.18.18
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-2.0')
pkg_upstream_url=https://wiki.debian.org/dpkg
pkg_description="dpkg is a package manager for Debian-based systems"
pkg_source=http://http.debian.net/debian/pool/main/d/${pkg_name}/${pkg_name}_${pkg_version}.tar.xz
pkg_shasum=c88b61e3d4660500753142689e8ddbeff1c731f29549f3338e6975f655936ff5
pkg_deps=(
  core/bzip2
  core/glibc
  core/tar
  core/zlib
  core/xz
)
pkg_build_deps=(
  core/autoconf
  core/automake
  core/bzip2
  core/gcc
  core/gettext
  core/libtool
  core/make
  core/ncurses
  core/perl
  core/pkg-config
  core/xz
  core/zlib
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)