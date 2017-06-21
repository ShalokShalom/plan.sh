pkg_origin=cosmos

pkg_name=a52dec
pkg_version=0.7.4.1
pkg_description="liba52 is a free library for decoding ATSC A/52 streams."
pkg_upstream_url="http://liba52.sourceforge.net/"
pkg_license=('GPL2')
pkg_deps=('glibc')
#pkg_source=("http://liba52.sourceforge.net/files/${pkg_name}-${pkg_version}.tar.gz"
pkg_source=("http://liba52.cvs.sourceforge.net/viewvc/liba52/?view=tar"
        'a52dec-0.7.4-build.patch')
pkg_shasum=('63970bf30401b6dea08178b65c2ff28c'
         'fa16f224a7dceb7613824380abef0052')

do_build() {
  #patch -p1 -i ${CACHE_PATH}/a52dec-0.7.4-build.patch
  
  ./bootstrap
  ./configure --prefix=/usr --enable-shared
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install
  
  install -m644 liba52/a52_internal.h ${pkg_prefix}/usr/include/a52dec/
}
