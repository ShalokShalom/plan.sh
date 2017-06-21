pkg_origin=cosmos

pkg_name=libxvmc
pkg_version=1.0.10
pkg_description="X11 Video Motion Compensation extension library"
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_license=('custom')
pkg_deps=('libxv')
pkg_build_deps=('pkgconfig')
pkg_source=("http://xorg.freedesktop.org/releases/individual/lib/libXvMC-${pkg_version}.tar.bz2")
pkg_shasum=('4cbe1c1def7a5e1b0ed5fce8e512f4c6')

do_build() {
  
  ./configure --prefix=/usr --sysconfdir=/etc --disable-static
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install
  
  install -m755 -d ${pkg_prefix}/usr/share/licenses/${pkg_name}
  install -m644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/
}
