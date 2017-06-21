pkg_origin=cosmos

pkg_name=itstool
pkg_version=2.0.2
pkg_description="XML to PO and back again"
pkg_upstream_url="http://itstool.org/"
pkg_license=('GPL3')
pkg_deps=('python2' 'libxml2')
pkg_source=("http://files.itstool.org/itstool/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('d472d877a7bc49899a73d442085b2f93')

do_build() {
  
  ./configure --prefix=/usr
  make
}

check() {
  
  make -k check
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
