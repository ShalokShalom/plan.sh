pkg_origin=

pkg_name=mediainfolib
_pkg_name=MediaInfoLib
pkg_version=0.7.96
pkg_description="Convenient unified display of the most relevant technical and tag data for video and audio files, shared libraries"
pkg_upstream_url="https://github.com/MediaArea/MediaInfoLib"
pkg_license=('GPL')
pkg_deps=('curl' 'libmms' 'zenlib')
pkg_build_deps=('libtool')
pkg_source=("https://github.com/MediaArea/MediaInfoLib/archive/v${pkg_version}.tar.gz")
pkg_shasum=('58019ab7b2b2ab374dee2cd7c011165d')

do_build() {
  cd ${_pkg_name}-${pkg_version}/Project/GNU/Library
  
  ./autogen.sh
  ./configure --prefix=/usr \
    --enable-shared \
    --disable-static \
    --with-libcurl \
    --with-libmms
  make
}
do_package() {
  cd ${_pkg_name}-${pkg_version}/Project/GNU/Library
  make DESTDIR=${pkg_prefix} install
  
  cd ../../..

  install -dm 755 ${pkg_prefix}/usr/lib/pkgconfig
  install -m 644 Project/GNU/Library/libmediainfo.pc $pkg_prefix/usr/lib/pkgconfig
}
