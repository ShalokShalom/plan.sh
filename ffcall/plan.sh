pkg_origin=cosmos

pkg_name=ffcall
pkg_version=1.10
pkg_description="C library for implementing foreign function calls in embedded interpreters"
pkg_upstream_url="http://www.haible.de/bruno/packages-ffcall.html"
pkg_license=('GPL2')
pkg_source=("http://www.haible.de/bruno/gnu/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('2db95007e901f3bc2ae7e5a9fe9ebea4')

do_build() {
  CONFIGFLAG="--with-pic"
  
  ./configure --prefix=/usr --mandir=/usr/share/man $CONFIGFLAG
  make
}

check() {
  
  make check
}

do_package() {
  
  install -d ${pkg_prefix}/usr/share/{man,doc/ffcall}
  make DESTDIR=${pkg_prefix} htmldir=/usr/share/doc/ffcall install
}
