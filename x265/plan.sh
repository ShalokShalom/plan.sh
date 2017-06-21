pkg_origin=cosmos

# rebuild ffmpeg, gst-plugins-bad, vlc & avidemux on updates
pkg_name=x265
pkg_version=2.4
_pkg_version=11047
pkg_description='H.265/HEVC encoder available anywhere, offering the highest compression efficiency and the highest performance.'
pkg_upstream_url='http://x265.readthedocs.org/en/default/'
pkg_license=('GPL')
pkg_deps=('gcc-libs')
pkg_build_deps=('cmake' 'yasm')
pkg_source=("https://bitbucket.org/multicoreware/x265/downloads/${pkg_name}_${pkg_version}.tar.gz")
pkg_shasum=('ab0986aa5c4465b874de94095b0d0cae')

do_build() {
  
  cmake -DCMAKE_INSTALL_PREFIX=/usr -DHIGH_BIT_DEPTH=ON source
  make
}

do_package() {
  
  make DESTDIR=${CACHE_PATH} install
}
