pkg_origin=

pkg_name=zulucrypt
_pkg_name=zuluCrypt
pkg_version=5.1.0
pkg_description="Simple,feature rich and powerful solution for hard drives encryption."
pkg_upstream_url="http://mhogomchungu.github.io/zuluCrypt/"
pkg_license=('GPL') 
pkg_deps=('cryptsetup' 'libpwquality' 'libsecret' 'libxkbcommon' 'qt5-base' 'kwalletmanager')
pkg_build_deps=('cmake')
pkg_source=("https://github.com/mhogomchungu/zuluCrypt/releases/download/${pkg_version}/${_pkg_name}-${pkg_version}.tar.xz") 
pkg_shasum=('b461206251e4e689f006d472405b13f5')

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${_pkg_name}-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr/ \
    -DCMAKE_BUILD_TYPE=release \
    -DLIB_SUFFIX=lib \
    -DNOGUI=OFF \
    -DQT5=ON \
    -DHOMEMOUNTPREFIX=OFF \
    -DNOKDE=OFF 
  make
}

do_package() {
  cd build

  make DESTDIR=$pkg_prefix install
}

