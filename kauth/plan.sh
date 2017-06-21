pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kauth
pkg_version=${_kf5ver}
pkg_description='KAuth provides a convenient, system-integrated way to offload actions that need to be performed as a privileged user.'
pkg_upstream_url='https://github.com/KDE/kauth'
pkg_license=('LGPL')
pkg_deps=('kcoreaddons' 'polkit-qt5')
pkg_build_deps=('extra-cmake-modules' 'qt5-tools')
pkg_source=("http://download.kde.org/stable/frameworks/5.33/${pkg_name}-${pkg_version}.tar.xz"
        'deadlock.patch'
        "https://github.com/KDE/kauth/commit/df875f725293af53399f5146362eb158b4f9216a.diff")
pkg_shasum=(`grep ${pkg_name}-$_kf5ver.tar.xz ../kf5.md5 | cut -d" " -f1`
         '150cefa733d5f51d174b91c6183a638d'
         '0aebfa8962c7320bd054f231f81e9a15')

do_prepare() {
  cd $pkg_name-${pkg_version}
  
  patch -p1 -i ${CACHE_PATH}/deadlock.patch
  # CVE-2017-8422
  #patch -p1 -i ${CACHE_PATH}/df875f725293af53399f5146362eb158b4f9216a.diff
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
    -DECM_MKSPECS_INSTALL_DIR=/usr/lib/qt5/mkspecs/modules \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF
  make
}

do_package() {
  cd build
  
  make DESTDIR="${pkg_prefix}" install
}
