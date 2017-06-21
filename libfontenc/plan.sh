pkg_origin=cosmos

pkg_name=libfontenc
pkg_version=1.1.3
pkg_description="X11 font encoding library"
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_license=('custom')
pkg_deps=('zlib')
pkg_build_deps=('pkgconfig' 'xproto')
pkg_source=("http://xorg.freedesktop.org/releases/individual/lib/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('0920924c3a9ebc1265517bdd2f9fde50')

do_build() {
  
  ./configure --prefix=/usr --sysconfdir=/etc \
      --localstatedir=/var --disable-static \
      --with-encodingsdir=/usr/share/fonts/encodings
  make
}

do_package() {
  make DESTDIR="${pkg_prefix}" install
  
  install -m755 -d "${pkg_prefix}/usr/share/licenses/${pkg_name}"
  install -m644 COPYING "${pkg_prefix}/usr/share/licenses/${pkg_name}/"
}
