pkg_origin=cosmos
pkg_name=libxt
pkg_version=1.1.5
pkg_description="X11 toolkit intrinsics library"
pkg_upstream_url="https://xorg.freedesktop.org/"
pkg_license=('custom')
pkg_deps=('xorg/libsm' 'cosmos/libx11')
pkg_build_deps=('cosmos/util-macros')
pkg_source=("https://xorg.freedesktop.org/releases/individual/lib/libXt-${pkg_version}.tar.bz2")

build() {
  cd libXt-${pkg_version}
  
  ./configure --prefix=/usr --sysconfdir=/etc --disable-static
  make
}

package() {
  cd libXt-${pkg_version}
  make DESTDIR=${pkg_prefix} install

  install -m755 -d ${pkg_prefix}/usr/share/licenses/${pkg_name}
  install -m644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/
}
