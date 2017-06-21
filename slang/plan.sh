pkg_origin=cosmos

pkg_name=slang
pkg_version=2.3.1.1
_pkg_version=2.3.1a
pkg_description="S-Lang is a powerful interpreted language"
pkg_upstream_url="http://www.jedsoft.org/slang/"
pkg_license=('GPL')
pkg_deps=('glibc' 'pcre' 'zlib')
backup=('etc/slsh.rc')
pkg_source=("http://www.jedsoft.org/releases/slang/${pkg_name}-${_pkg_version}.tar.bz2")
sha1sums=('a8ea7f1b5736160a94efb67b137a0f5b9916bdf2')

do_build() {
  
  ./configure --prefix=/usr --sysconfdir=/etc 
  make
}

do_check() {
  
  make check
}


do_package() {
  
  make DESTDIR=${CACHE_PATH} install-all
}
