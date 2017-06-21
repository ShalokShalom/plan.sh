pkg_origin=cosmos

pkg_name=libxi
pkg_version=1.7.9
pkg_description="X11 Input extension library"
pkg_upstream_url="https://xorg.freedesktop.org"
pkg_deps=('libxext' 'inputproto' 'libxfixes')
pkg_build_deps=('pkgconfig' 'xorg-util-macros')
pkg_license=('custom')
pkg_source=("https://xorg.freedesktop.org/releases/individual/lib/libXi-${pkg_version}.tar.bz2")
pkg_shasum=('1f0f2719c020655a60aee334ddd26d67')


do_build() {
  
  ./configure --prefix=/usr \
        --sysconfdir=/etc \
        --disable-static
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install

  install -m755 -d ${pkg_prefix}/usr/share/licenses/${pkg_name}
  install -m644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/
}
