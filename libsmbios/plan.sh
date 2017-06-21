pkg_origin=cosmos
# $Id: PKGBUILD 78087 2010-04-19 09:25:42Z dgriffiths $
# Maintainer: Jan de Groot <jgc@archlinux.org>
# Contributor: Alessio 'mOLOk' Bolognino <themolok@gmail.com>
# Contributor: daniel g. siegel <dgsiegel@gmail.com> 

pkg_name=libsmbios
pkg_version=2.2.16
pkg_description="A library for providing access to as much BIOS information as possible"
pkg_upstream_url="http://linux.dell.com/libsmbios/main/index.html"
pkg_license=('GPL' 'custom')
pkg_deps=('gcc-libs>=4.3.3')
pkg_build_deps=('libxml2')
pkg_deps=('python: tools')
pkg_source=(http://linux.dell.com/libsmbios/download/${pkg_name}/${pkg_name}-${pkg_version}/${pkg_name}-${pkg_version}.tar.gz)
pkg_shasum=('6edf6659fbb77e7d0f60d5217a7d88ed')

do_build() {
  mkdir build
  ../configure --prefix=/usr --sysconfdir=/etc --disable-static || return 1
  mkdir -p out/libsmbios_c
  mkdir -p out/libsmbios_c++
  LD_PRELOAD="" make || return 1
  make DESTDIR="${pkg_prefix}" install || return 1
  install -m755 -d "${pkg_prefix}/usr/include"
  cp -a ../src/include/* "${pkg_prefix}/usr/include/" || return 1
  cp -a out/public-include/* "${pkg_prefix}/usr/include/" || return 1

  rm -rf "${pkg_prefix}/etc/yum"

  install -m755 -d "${pkg_prefix}/usr/share/licenses/${pkg_name}"
  install -m644 ../COPYING-OSL "${pkg_prefix}/usr/share/licenses/${pkg_name}/" || return 1
}
