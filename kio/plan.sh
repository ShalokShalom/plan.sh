pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kio
pkg_version=${_kf5ver}
pkg_description='Framework that implements almost all the file management functions you will ever need'
pkg_upstream_url='https://projects.kde.org/projects/frameworks/kio'
pkg_license=('LGPL')
pkg_deps=('karchive' 'kconfig' 'kcoreaddons' 'kdbusaddons' 'ki18n' 'kservice' 'solid'
         'kbookmarks' 'kcompletion' 'kconfigwidgets' 'kiconthemes' 'kitemviews' 'kjobwidgets'
         'kwidgetsaddons' 'kwindowsystem' 'kwallet' 'knotifications' 'krb5' 'qt5-script')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
pkg_source=("http://download.kde.org/stable/frameworks/5.20/${pkg_name}-${pkg_version}.tar.xz"
        'kauth4.diff')
pkg_shasum=(`grep ${pkg_name}-${_kf5ver}.tar.xz ../kf5.md5 | cut -d" " -f1`
         '093017bbf68b63d2ddc658b84fe021b9')

do_prepare() {
  cd ${pkg_name}-${pkg_version}
  # GSOC project to include root operation, target dolphin
  # https://docs.google.com/document/d/1LhuHwwo_hCziM2-3UsffpODwnjypYQjMnB7YHEQd4dQ
  patch -p1 -i ${CACHE_PATH}/kauth4.diff
  #sed -i -e 's|-caption=|-qwindowtitle|' src/core/desktopexecparser.cpp
}
         
do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_LIBEXECDIR=lib \
    -DKDE_INSTALL_SYSCONFDIR=/etc \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF
  make
}

do_package() {
  cd build
  
  make DESTDIR="${pkg_prefix}" install
}
