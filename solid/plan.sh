pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=solid
pkg_version=${_kf5ver}
pkg_description='Solid'
pkg_upstream_url='https://projects.kde.org/projects/frameworks/solid'
pkg_license=('LGPL')
pkg_deps=('media-player-info' 'qt5-declarative' 'upower' 'udisks2')
pkg_build_deps=('extra-cmake-modules' 'qt5-tools')
pkg_source=("http://download.kde.org/stable/frameworks/${pkg_version}/${pkg_name}-${pkg_version}.tar.xz"
        "https://raw.githubusercontent.com/frugalware/frugalware-current/master/source/kf5/solid/sort_cores.patch")
pkg_shasum=(`grep ${pkg_name}-$_kf5ver.tar.xz ../kf5.md5 | cut -d" " -f1`
         'e086776ae503f25f40b558ff0dd8579a')

prepare () {
  cd $pkg_name-$pkg_version
  # patch from frugalware, make sure cpu's show correct
  patch -p1 -i $CACHE_PATH/sort_cores.patch
}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DLIB_INSTALL_DIR=lib \
    -DQML_INSTALL_DIR=/usr/lib/qt5/qml \
    -DECM_MKSPECS_INSTALL_DIR=/usr/lib/qt5/mkspecs/modules \
    -DPLUGIN_INSTALL_DIR=/usr/lib/qt5/plugins \
    -DBUILD_TESTING=OFF 
  make
}

do_package() {
  cd build

  make DESTDIR="${pkg_prefix}" install
}

