pkg_origin=cosmos

pkg_name=libid3tag
pkg_version=0.15.1b
pkg_description="library for id3 tagging"
pkg_upstream_url="http://www.underbit.com/products/mad/"
pkg_license=('GPL')
pkg_deps=('zlib')
pkg_build_deps=('gperf')
pkg_source=("ftp://ftp.mars.org/pub/mpeg/${pkg_name}-${pkg_version}.tar.gz"
        'id3tag.pc'
        '10_utf16.diff'
        '11_unknown_encoding.diff'
        'CVE-2008-2109.patch')
pkg_shasum=('e5808ad997ba32c498803822078748c3'
         '8bb41fd814fafcc37ec8bc88f5545a4a'
         '4f9df4011e6a8c23240fff5de2d05f6e'
         '3ca856b97924d48a0fdfeff0bd83ce7d'
         'c51822ea6301b1ca469975f0c9ee8e34')

do_build() {
  
  patch -p1 -i ${CACHE_PATH}/10_utf16.diff
  patch -p1 -i ${CACHE_PATH}/11_unknown_encoding.diff
  patch -p0 -i ${CACHE_PATH}/CVE-2008-2109.patch
  
  ./configure --prefix=/usr
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install
  
  install -D -m644 ${CACHE_PATH}/id3tag.pc ${pkg_prefix}/usr/lib/pkgconfig/id3tag.pc
}
