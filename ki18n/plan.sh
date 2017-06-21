pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=ki18n
pkg_version=${_kf5ver}
pkg_description='Ki18n'
pkg_upstream_url='https://github.com/KDE/ki18n'
pkg_license=('LGPL')
pkg_deps=('kjs' 'qt5-script' 'qt5-declarative')
pkg_build_deps=('extra-cmake-modules')
pkg_source=("http://download.kde.org/stable/frameworks/5.20/${pkg_name}-${pkg_version}.tar.xz"
        "https://github.com/KDE/ki18n/commit/e02b02a4e1a0897f959cad8c7e92c8f60f168b40.diff")
pkg_shasum=(`grep ${pkg_name}-${_kf5ver}.tar.xz ../kf5.md5 | cut -d" " -f1`
         '2194625dfdcc2623fce121df9b0711c4')

prepare () {
  cd ${pkg_name}-${pkg_version}
  
  #patch -p1 -i ${CACHE_PATH}/e02b02a4e1a0897f959cad8c7e92c8f60f168b40.diff
}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DECM_MKSPECS_INSTALL_DIR=/usr/lib/qt5/mkspecs/modules \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DBUILD_TESTING=OFF
  make
}

do_package() {
  cd build
  
  make DESTDIR="${pkg_prefix}" install
  # conflicts with kde-l10n since kf5 5.20.0
  rm ${pkg_prefix}/usr/share/locale/nb/LC_SCRIPTS/ki18n5/ki18n5.js
  rm ${pkg_prefix}/usr/share/locale/nn/LC_SCRIPTS/ki18n5/ki18n5.js
  rm ${pkg_prefix}/usr/share/locale/nn/LC_SCRIPTS/ki18n5/skjermelement.pmap
  rm ${pkg_prefix}/usr/share/locale/nn/LC_SCRIPTS/ki18n5/skjermelement.pmapc
}
