pkg_origin=cosmos

pkg_name=fastjar
pkg_version=0.98
pkg_description="Sun java jar compatible archiver"
pkg_upstream_url="http://savannah.nongnu.org/projects/fastjar"
pkg_license=('GPL')
pkg_deps=('zlib' 'texinfo')
pkg_source=("http://download.savannah.nongnu.org/releases/${pkg_name}/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('d2d264d343d4d0e1575832cc1023c3bf')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
