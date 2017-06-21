pkg_origin=cosmos

pkg_name=libxcomposite
pkg_version=0.4.4
pkg_description="X11 Composite extension library"
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_license=('custom')
pkg_deps=('libxfixes' 'compositeproto')
pkg_build_deps=('xorg-util-macros')
pkg_source=("http://xorg.freedesktop.org/releases/individual/lib/libXcomposite-${pkg_version}.tar.bz2")
pkg_shasum=('f7a218dcbf6f0848599c6c36fc65c51a')

do_build() {
  
  ./configure --prefix=/usr --sysconfdir=/etc --disable-static
  make
}

do_package() {
  make DESTDIR="${pkg_prefix}" install

  install -m755 -d "${pkg_prefix}/usr/share/licenses/${pkg_name}"
}
