pkg_origin=

pkg_name=sirikali
pkg_version=1.2.7
pkg_description="GUI application that manages ecryptfs, cryfs, encfs, gocryptfs and securefs based encrypted folders."
pkg_upstream_url="https://mhogomchungu.github.io/sirikali/"
pkg_license=('GPL') 
pkg_deps=('encfs' 'libgcrypt' 'libpwquality'  'libxkbcommon' 'qt5-base' 'kwalletmanager' 'libsecret')
pkg_build_deps=('cmake')
pkg_source=("https://github.com/mhogomchungu/sirikali/releases/download/${pkg_version}/${pkg_name}-${pkg_version}.tar.xz") 
pkg_shasum=('5c19b862f995d785c1d1e8444793df01')

do_build() {
  mkdir -p build
  cd build
  
  cmake ../SiriKali-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr/ \
    -DCMAKE_BUILD_TYPE=release \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DQT5=true \
    -DNOSECRETSUPPORT=false \
    -DNOKDESUPPORT=false \
    -DINTERNAL_LXQT_WALLET=false
  make
}

do_package() {
  cd build

  make DESTDIR=$pkg_prefix install
}

