pkg_origin=cosmos

pkg_name=cairomm
pkg_version=1.12.2
pkg_description="C++ bindings to Cairo vector graphics library"
pkg_upstream_url="https://www.cairographics.org/cairomm/"
pkg_license=('LGPL' 'MPL')
pkg_deps=('cairo' 'libsigc++')
pkg_build_deps=('pkgconfig')
pkg_source=("https://www.cairographics.org/releases/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('9d2282ea34cf9aaa89208bb4bb911909')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
