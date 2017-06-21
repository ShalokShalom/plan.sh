pkg_origin=

pkg_name=fatrat
pkg_version=1.2.0.4
_commit=14a1a146df76d70c44dcc38363848a5b41a364d5
pkg_description='Open source download manager for Linux written in C++ and built on top of Qt'
pkg_upstream_url='http://fatrat.dolezel.info/'
pkg_license=('GPLv3')
pkg_deps=('curl' 'qt5-svg' 'qtwebengine' 'boost-libs' 'libtorrent-rasterbar')
pkg_build_deps=('cmake' 'qt5-tools' 'boost')
pkg_source=("https://github.com/LubosD/fatrat/archive/${_commit}.zip")
pkg_shasum=('0684d046b14f73f7f94e81387498c22b')

do_prepare() {
  cd ${pkg_name}-${_commit}
  #sed -i -e 's|find_package(Qca 2.1.0)|find_package(Qca 2.1.0 NAMES Qca-qt5 Qca)|' ${CACHE_PATH}/${pkg_name}/CMakeLists.txt
}

do_build() {
  mkdir -p build
  cd build

  cmake ../${pkg_name}-${_commit} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DWITH_BITTORRENT=ON \
    -DWITH_NLS=ON \
    -DWITH_Cpkg_upstream_url=ON  
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}

