pkg_origin=cosmos

pkg_name=libxfixes
pkg_version=5.0.3
pkg_description="X11 miscellaneous 'fixes' extension library"
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_license=('custom')
pkg_deps=('libx11' 'fixesproto>=5.0')
pkg_build_deps=('xorg-util-macros')
pkg_source=("http://xorg.freedesktop.org/releases/individual/lib/libXfixes-${pkg_version}.tar.bz2")
pkg_shasum=('07e01e046a0215574f36a3aacb148be0')

do_build() {
  
  ./configure --prefix=/usr --sysconfdir=/etc --disable-static
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install

  install -m755 -d ${pkg_prefix}/usr/share/licenses/${pkg_name}
  install -m644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/
}
