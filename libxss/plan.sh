pkg_origin=cosmos

pkg_name=libxss
pkg_version=1.2.2
pkg_description="X11 Screen Saver extension library"
pkg_license=('custom')
pkg_upstream_url="https://xorg.freedesktop.org/"
pkg_deps=('libxext' 'scrnsaverproto')
pkg_build_deps=('xorg-util-macros')
pkg_source=("https://xorg.freedesktop.org/releases/individual/lib/libXScrnSaver-${pkg_version}.tar.bz2")
pkg_shasum=('7a773b16165e39e938650bcc9027c1d5')

do_build() {
  
  ./configure --prefix=/usr --sysconfdir=/etc
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install

  install -Dm644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/COPYING
}
