pkg_origin=cosmos
pkg_name=libxrandr
pkg_version=1.5.1
pkg_description="X11 RandR extension library"
pkg_license=('custom')
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_deps=('cosmos/libxext' 'xorg/libXrender' 'cosmos/randrproto')
pkg_build_deps=('cosmos/util-macros')
pkg_source=("http://xorg.freedesktop.org/releases/individual/lib/libXrandr-${pkg_version}.tar.bz2")
pkg_shasum=('')

build() {
  cd libXrandr-${pkg_version}
  
  ./configure --prefix=/usr --sysconfdir=/etc
  make  
}

package() {
  cd libXrandr-${pkg_version}
  make DESTDIR=${pkg_prefix} install
  
  install -d -m755 ${pkg_prefix}/usr/share/licenses/${pkg_name}
  install -m644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/
}
