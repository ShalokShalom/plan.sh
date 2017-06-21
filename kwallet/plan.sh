pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kwallet
pkg_version=${_kf5ver}
pkg_description='KWallet Framework'
pkg_upstream_url='https://projects.kde.org/projects/frameworks/kwallet-framework'
pkg_license=('LGPL')
pkg_deps=('kcoreaddons' 'kconfig' 'kwindowsystem' 'ki18n' 'kiconthemes' 'knotifications'
         'kconfigwidgets' 'kdbusaddons' 'kservice' 'kwidgetsaddons' 'gpgme')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'boost')
pkg_source=("http://download.kde.org/stable/frameworks/${pkg_version}/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=(`grep ${pkg_name}-${_kf5ver}.tar.xz ../kf5.md5 | cut -d" " -f1`)
#pkg_source=("https://github.com/KDE/kwallet/archive/0d56c68d7a2204a987a5255096d004d5a696c0e5.zip")
#pkg_shasum=('dd185a466e38bf6528f066c9006348c9')

#do_prepare() {
  #cd ${pkg_name}-${pkg_version}
  # 5.22.0 early tar https://bugs.kde.org/show_bug.cgi?id=362805
  #patch -p1 -i ${CACHE_PATH}/87e774825b779ba846315a8b2ffe6479dd9f9814.diff
  #patch -p1 -Ri ${CACHE_PATH}/b3a95ba0540e01a9bb10db53fc449cc49ce9a9e8.diff
#}

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
  
  make DESTDIR=${pkg_prefix} install
}
