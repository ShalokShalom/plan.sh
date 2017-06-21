pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=frameworkintegration
pkg_version=${_kf5ver}
pkg_description='Framework providing components to allow applications to integrate with a KDE Workspace'
pkg_upstream_url='https://github.com/KDE/frameworkintegration'
pkg_license=('LGPL')
pkg_deps=('kconfig' 'kconfigwidgets' 'ki18n' 'kiconthemes' 'kio' 'knotifications' 
         'kwidgetsaddons' 'kpackage' 'knewstuff' 'noto-fonts' 'libxcursor' 'ttf-dejavu')
pkg_build_deps=('extra-cmake-modules')
pkg_source=("http://download.kde.org/stable/frameworks/5.15/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=(`grep ${pkg_name}-${_kf5ver}.tar.xz ../kf5.md5 | cut -d" " -f1`)

do_prepare() {
  cd $pkg_name-${pkg_version}
  # http://quickgit.kde.org/?p=frameworkintegration.git&a=commit&h=26406a9aa01d6f4f01a3f084b51451de8385c8fc
  # use only the last patch
  #patch -p1 -i $CACHE_PATH/file_dialog.diff
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
  
  make DESTDIR="${pkg_prefix}" install
}
