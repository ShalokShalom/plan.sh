pkg_origin=cosmos

pkg_name=pth
pkg_version=2.0.7
pkg_description="The GNU Portable Threads."
pkg_upstream_url="http://www.gnu.org/software/pth/"
pkg_license=('LGPL')
pkg_deps=('glibc' 'awk')
pkg_source=("ftp://ftp.gnu.org/gnu/pth/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('9cb4a25331a4c4db866a31cbe507c793')

do_build() {
  
  ./configure --prefix=/usr \
       --sysconfdir=/etc \
       --localstatedir=/var \
       --mandir=/usr/share/man \
       --disable-static \
       --enable-shared \
       --with-pic
       
  sed -i "s|awk=''|awk=/bin/awk|g" shtool 
  
  make 
}

do_check() {

  make check
}

do_package() {
  
  make DESTDIR=${CACHE_PATH} install 
}
