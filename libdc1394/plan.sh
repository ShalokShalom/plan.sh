pkg_origin=cosmos

pkg_name=libdc1394
pkg_version=2.2.5
pkg_description="High level programming interface to control IEEE 1394 based cameras"
pkg_license=('LGPL')
pkg_upstream_url="http://sourceforge.net/projects/libdc1394/"
pkg_deps=('libraw1394' 'libusbx')
pkg_source=("http://downloads.sourceforge.net/sourceforge/libdc1394/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('01acfcde2cc85863b0acb90dcffa1659')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}

