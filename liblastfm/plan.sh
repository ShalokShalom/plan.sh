pkg_origin=cosmos

pkg_name=liblastfm
pkg_version=1.0.9
_pkg_version=5826fe6
pkg_description='A Qt C++ library for the Last.fm webservices'
pkg_upstream_url="https://github.com/lastfm/liblastfm/"
pkg_license=('GPL3')
pkg_deps=('qt5-base')
pkg_build_deps=('lsb-release' 'cmake')
pkg_source=("https://github.com/lastfm/liblastfm/archive/${pkg_version}.tar.gz")
pkg_shasum=('8748f423f66f2fbc38c39f9153d01a71')

do_build() {
  mkdir build

  cmake ../${pkg_name}-${pkg_version} \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DCMAKE_INSTALL_LIBDIR=/usr/lib \
        -DBUILD_FINGERPRINT=off \
        -DCMAKE_BUILD_TYPE=Release \
        
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}

