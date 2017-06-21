pkg_origin=cosmos

pkg_name=libmcrypt
pkg_version=2.5.8
pkg_description="Library which provides a uniform interface to several symmetric encryption algorithms"
pkg_upstream_url="http://mcrypt.sourceforge.net/"
pkg_license=('GPL')
pkg_deps=('glibc')
pkg_source=("https://downloads.sourceforge.net/mcrypt/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('c4f491dd411a09e9de3b8702ea6f73eb')

do_build() {

  ./configure --prefix=/usr --mandir=/usr/share/man
  make
}

check() {
  
  make check
}

do_package() {

  make DESTDIR=${pkg_prefix} install
}
