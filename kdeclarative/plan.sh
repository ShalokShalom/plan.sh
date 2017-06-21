pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kdeclarative
pkg_version=${_kf5ver}
pkg_description='KDeclarative'
pkg_upstream_url='https://projects.kde.org/projects/frameworks/kdeclarative'
pkg_license=('LGPL')
pkg_deps=('kconfig' 'ki18n' 'kiconthemes' 'kio' 'kwidgetsaddons' 'kwindowsystem' 'kglobalaccel' 
         'kguiaddons' 'kpackage' 'libepoxy')
pkg_build_deps=('extra-cmake-modules')
pkg_source=("http://download.kde.org/stable/frameworks/${pkg_version}/${pkg_name}-${pkg_version}.tar.xz"
        "https://github.com/KDE/kdeclarative/commit/695f24fb522a5ae6fe2530cbd72d3966b234b025.diff")
pkg_shasum=(`grep ${pkg_name}-${_kf5ver}.tar.xz ../kf5.md5 | cut -d" " -f1`
         '8d5370fdbbd9cb61ef7c3fd790beb5a1')

do_prepare() {
  cd ${pkg_name}-${pkg_version}
  # https://bugs.kde.org/show_bug.cgi?id=380270
  #patch -p1 -i ${CACHE_PATH}/695f24fb522a5ae6fe2530cbd72d3966b234b025.diff
}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_QMLDIR=/usr/lib/qt5/qml \
    -DECM_MKSPECS_INSTALL_DIR=/usr/lib/qt5/mkspecs/modules \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DBUILD_TESTING=OFF
  make
}

do_package() {
  cd build
  
  make DESTDIR="${pkg_prefix}" install
}
