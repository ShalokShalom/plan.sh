pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=ksysguard
pkg_version=${_plasmaver}
pkg_description='KSysGuard is a program to monitor various elements of your system'
pkg_upstream_url='https://github.com/KDE/ksysguard'
pkg_license=('LGPL')
pkg_deps=('kcoreaddons' 'kconfig' 'ki18n' 'kiconthemes' 'knewstuff' 'kdelibs4support' 'libksysguard' 'lm_sensors')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
pkg_source=("http://download.kde.org/stable/plasma/${pkg_version}/${pkg_name}-${pkg_version}.tar.xz")
#pkg_source=("${pkg_name}-${pkg_version}.tar.gz::https://github.com/KDE/${pkg_name}/archive/${_branch}.tar.gz")
# grep md5 picks up libksysguard too
pkg_shasum=('564edbecc287cff1fc78912cf6d8d923')

do_prepare() {
  cd ${pkg_name}-${pkg_version}
  #sed -i -e 's/Kdcraw/KF5KDcraw/' ${CACHE_PATH}/${pkg_name}-${pkg_version}/CMakeLists.txt
  #patch -p1 -i $CACHE_PATH/kdbus.diff
  
}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_SYSCONFDIR=/etc \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF
  make
}

do_package() {
  cd build
  make DESTDIR=${pkg_prefix} install
  
  rm -r ${pkg_prefix}/usr/share/locale
}

