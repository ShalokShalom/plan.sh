pkg_origin=cosmos

pkg_name=chmlib
pkg_version=0.40
pkg_description="Library for reading Microsoft ITSS/CHM format files"
pkg_upstream_url="http://www.jedrea.com/chmlib/"
pkg_license=('LGPL')
pkg_deps=('glibc')
pkg_source=("http://www.jedrea.com/chmlib/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('7ea49ed8c335215c1edc6fae83e6b912')

do_build() {
  
  ./configure --prefix=/usr --enable-examples=yes
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}

