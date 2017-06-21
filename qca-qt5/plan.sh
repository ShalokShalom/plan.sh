pkg_origin=cosmos

pkg_name=qca-qt5
_pkg_name=qca
pkg_version=2.1.3
pkg_description="Qt Cryptographic Architecture"
pkg_upstream_url="http://delta.affinix.com/qca/"
pkg_license=('LGPL')
pkg_deps=('qt5-base' 'ca-certificates' 'nss')
pkg_build_deps=('cmake')
#pkg_source=("http://delta.affinix.com/download/qca/2.0/${_pkg_name}-${pkg_version}.tar.gz")
pkg_source=("http://download.kde.org/stable/qca/${pkg_version}/src/${_pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('5019cc29efcf828681cd93164238ce26')

do_prepare() {
  #patch -p1 -i ${CACHE_PATH}/qt5.5.diff
}

do_build() {
  mkdir -p build
  
  cmake ../${_pkg_name}-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DQCA_SUFFIX=qt5 \
    -DQCA_INSTALL_IN_QT_PREFIX=ON
  make 
}

do_package() {
  
  make DESTDIR=${CACHE_PATH} install 
}
