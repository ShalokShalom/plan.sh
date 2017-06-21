pkg_origin=cosmos

pkg_name=libart-lgpl
pkg_version=2.3.21
pkg_description="A library for high-performance 2D graphics"
pkg_upstream_url="http://www.levien.com/libart/"
pkg_license=('LGPL')
pkg_deps=('glibc')
pkg_source=("https://download.gnome.org/sources/libart_lgpl/2.3/libart_lgpl-${pkg_version}.tar.bz2")
pkg_shasum=('08559ff3c67fd95d57b0c5e91a6b4302')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
