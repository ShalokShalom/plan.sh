pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=libksysguard
pkg_version=${_plasmaver}
pkg_description='Libksysguard'
pkg_upstream_url='https://projects.kde.org/projects/kde/workspace/libksysguard'
pkg_license=('LGPL')
pkg_deps=('libxres' 'kcoreaddons' 'kconfig' 'ki18n' 'kwindowsystem' 'kcompletion' 'kauth'
         'kwidgetsaddons' 'kiconthemes' 'kconfigwidgets' 'kservice' 'plasma-framework'
         'qtwebkit-tp')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
pkg_source=("http://download.kde.org/unstable/plasma/${pkg_version}/${pkg_name}-${pkg_version}.tar.xz")
#pkg_source=("${pkg_name}-${pkg_version}.tar.gz::https://github.com/KDE/${pkg_name}/archive/${_branch}.tar.gz")
pkg_shasum=(`grep ${pkg_name}-$_plasmaver.tar.xz ../kf5.md5 | cut -d" " -f1`)

do_prepare() {
  cd ${pkg_name}-${pkg_version}
  
  #patch -p1 -i ${CACHE_PATH}/isnan.diff
}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_LIBEXECDIR=lib \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF
  make
}

do_package() {
  cd build
  make DESTDIR=${pkg_prefix} install
  
  rm -r ${pkg_prefix}/usr/share/locale
}

