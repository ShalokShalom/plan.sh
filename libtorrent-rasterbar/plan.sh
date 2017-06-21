pkg_origin=

pkg_name=libtorrent-rasterbar
pkg_version=1.1.3
_pkg_version=1_1_3
pkg_description="A C++ library that aims to be a good alternative to all the other bittorrent implementations around"
pkg_upstream_url="http://www.rasterbar.com/products/libtorrent/"
pkg_license=('custom')
pkg_deps=('boost-libs' 'python2' 'geoip')
pkg_build_deps=('boost')
pkg_source=("https://github.com/arvidn/libtorrent/releases/download/libtorrent-${_pkg_version}/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('b2be2d5c5b23f733e61c33c377ce80b8')

do_build() {
  cd ${pkg_name}-${pkg_version}
  
  CXXFLAGS="-std=c++11"
  
  ./configure --prefix=/usr --enable-python-binding --with-libgeoip=system
  make
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  make DESTDIR=${pkg_prefix} install
  
  install -D COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
