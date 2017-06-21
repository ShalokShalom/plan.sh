pkg_origin=cosmos

pkg_name=libxcursor
pkg_version=1.1.14
pkg_description="X cursor management library"
pkg_upstream_url="https://xorg.freedesktop.org/"
pkg_license=('custom')
pkg_deps=('libxfixes' 'libxrender')
pkg_build_deps=('xorg-util-macros')
pkg_source=("https://xorg.freedesktop.org/releases/individual/lib/libXcursor-${pkg_version}.tar.bz2")
pkg_shasum=('1e7c17afbbce83e2215917047c57d1b3')

do_build() {
  
  ./configure --prefix=/usr --sysconfdir=/etc --disable-static
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install

  install -Dm644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/COPYING
}
