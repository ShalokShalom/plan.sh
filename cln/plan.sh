pkg_origin=cosmos

pkg_name=cln
pkg_version=1.3.4
pkg_description="Class library for numbers"
pkg_upstream_url="http://www.ginac.de/CLN/"
pkg_license=('GPL')
pkg_deps=('gmp' 'bash' 'texinfo')
pkg_build_deps=('texlive-core')
pkg_source=("http://www.ginac.de/CLN/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('30ef9d2f02ef5c3f8d221a8692f8b28e')

do_build() {
  
  ./configure --prefix=/usr
  make
}

check() {
  
  make check
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
