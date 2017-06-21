pkg_origin=cosmos

pkg_name=libde265
pkg_version=1.0.2
pkg_description="Open source implementation of the h.265 video codec."
pkg_upstream_url="http://www.libde265.org/"
pkg_license=('LGPL3')
pkg_deps=('sdl' 'qt5-base' 'ffmpeg')
pkg_build_deps=('cmake')
pkg_source=("https://github.com/strukturag/libde265/releases/download/v${pkg_version}/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('93520b378df25f3a94e962f2b54872cc')

do_build() {
  sed -ri 's/(PIX_FMT_)/AV_\1/g' sherlock265/VideoDecoder.cc

  ./configure --prefix=/usr
  make
}

do_package() {
  make PREFIX=/usr DESTDIR=${pkg_prefix} install

  rm -r ${pkg_prefix}/usr/lib/libde265.la
}

#do_build() {
#  mkdir -p build
#  cd build
#  
#  cmake ../${pkg_name}-$pkg_version \
#    -DCMAKE_BUILD_TYPE=Release \
#    -DCMAKE_INSTALL_PREFIX=/usr 
#  make
#}

#do_package() {
#  cd build
  
#  make DESTDIR=$pkg_prefix install

#  find "$pkg_prefix" -name "*.la" -delete
#}
