pkg_origin=

pkg_name=bitcoin
pkg_version=0.14.2
pkg_description="Bitcoin is a peer-to-peer network based digital currency"
pkg_upstream_url="http://www.bitcoin.org/"
pkg_license=('MIT')
pkg_deps=('boost-libs' 'qt5-base' 'miniupnpc' 'qrencode' 'protobuf' 'libevent' 'zeromq')
pkg_build_deps=('boost' 'qt5-tools')
#pkg_source=("git://github.com/bitcoin/bitcoin.git")
pkg_source=("https://github.com/bitcoin/bitcoin/archive/v${pkg_version}.tar.gz")
pkg_shasum=('e37fde4741b0bb1ece8c824646f0d61b')

do_build() {
  cd ${pkg_name}-${pkg_version}
  #CXXFLAGS="$CXXFLAGS -DBOOST_VARIANT_USE_RELAXED_GET_BY_DEFAULT=1"
  CXXFLAGS="-std=c++11"

  ./autogen.sh
  ./configure --prefix=/usr \
      --with-incompatible-bdb \
      --with-gui=qt5
  make
}


do_package() {
  cd ${pkg_name}-${pkg_version}
  make DESTDIR=${pkg_prefix} install

  install -Dm644 contrib/debian/bitcoin-qt.desktop ${pkg_prefix}/usr/share/applications/bitcoin.desktop
  install -Dm644 share/pixmaps/bitcoin128.png ${pkg_prefix}/usr/share/pixmaps/bitcoin128.png

  install -Dm644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/COPYING
}
