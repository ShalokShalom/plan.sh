pkg_origin=cosmos

pkg_name=libxml++
pkg_version=2.40.1
pkg_description="C++ bindings to libxml2."
pkg_license=('LGPL')
pkg_upstream_url="http://libxmlplusplus.sourceforge.net/"
pkg_deps=('glibmm' 'libxml2>=2.7.7')
pkg_source=("https://download.gnome.org/sources/libxml++/2.40/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('377a87bea899f2b4ff62df2418c3d8a6')

do_build() {

  ./configure --prefix=/usr 
  make
}

do_package() {

  make DESTDIR=${pkg_prefix} install
}
