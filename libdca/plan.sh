pkg_origin=cosmos

pkg_name=libdca
pkg_version=0.0.5
pkg_description="Free library for decoding DTS Coherent Acoustics streams"
pkg_upstream_url="http://www.videolan.org/developers/libdca.html"
pkg_license=('GPL')
pkg_deps=('sh')
pkg_source=("http://download.videolan.org/pub/videolan/libdca/${pkg_version}/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('dab6b2795c66a82a6fcd4f8343343021')

do_build() {
  
  ./configure --prefix=/usr --mandir=/usr/share/man
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install

  rm -f ${pkg_prefix}/usr/share/man/man1/{extract_dts,dtsdec}.1
  ln -s dcadec.1.gz ${pkg_prefix}/usr/share/man/man1/dtsdec.1.gz
  ln -s extract_dca.1.gz ${pkg_prefix}/usr/share/man/man1/extract_dts.1.gz
  rm ${pkg_prefix}/usr/lib/libdts.a
}
