pkg_origin=cosmos

pkg_name=libxv
pkg_version=1.0.11
pkg_description="X11 Video extension library"
pkg_license=('custom')
pkg_upstream_url="http://xorg.freedesktop.org/"
pkg_deps=('libxext' 'videoproto')
pkg_build_deps=('pkgconfig')
pkg_source=("http://xorg.freedesktop.org/releases/individual/lib/libXv-${pkg_version}.tar.bz2")
pkg_shasum=('210b6ef30dda2256d54763136faa37b9')

do_build() {
  
  ./configure --prefix=/usr --disable-static 
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install

  install -m755 -d ${pkg_prefix}/usr/share/licenses/${pkg_name}
  install -m644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/
}
