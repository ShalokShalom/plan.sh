pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=libkeduvocdocument
pkg_version=${_kdever}
pkg_description="Library to parse, convert, and manipulate KVTML files "
pkg_upstream_url='https://projects.kde.org/projects/kde/kdeedu/libkeduvocdocument'
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('kconfig' 'ki18n' 'karchive' 'kio')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
pkg_source=("$_mirror/${pkg_name}-$_kdever.tar.xz"
        'QFile.diff')
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`
         'ed559f15849258295e962a1c72769650')

do_prepare() {
  cd ${pkg_name}-${pkg_version}
  
  #patch -p1 -i ${CACHE_PATH}/QFile.diff
}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF 
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}
