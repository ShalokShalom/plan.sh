pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kwin
pkg_version=${_plasmaver}
pkg_description='KDE Window Manager'
pkg_upstream_url='https://github.com/KDE/kwin'
pkg_license=('LGPL')
pkg_deps=('qt5-multimedia' 'plasma-framework' 'kcmutils' 'kinit' 'knewstuff' 'xcb-util-cursor'
         'libepoxy' 'kwayland' 'kdecoration' 'libinput' 'kscreenlocker' 'breeze' 'qt5-virtualkeyboard'
         'xorg-server')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'qt5-tools')
#pkg_source=("http://download.kde.org/stable/plasma/$pkg_version/$pkg_name-$pkg_version.tar.xz")
pkg_source=("${pkg_name}-${pkg_version}.tar.gz::https://github.com/KDE/${pkg_name}/archive/${_branch}.tar.gz")
pkg_shasum=(`grep ${pkg_name}-${_plasmaver}.tar.gz ../kf5.md5 | cut -d" " -f1`)

prepare () {
  cd ${pkg_name}-${__pkg_version}
  #patch -p1 -i ${CACHE_PATH}/closeview.diff
  #sed -i 's|add_subdirectory(tests)|#add_subdirectory(tests)|' ${CACHE_PATH}/${pkg_name}-${pkg_version}/CMakeLists.txt
}  

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${__pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_LIBEXECDIR=lib \
    -DKDE_INSTALL_SYSCONFDIR=/etc \
    -DKDE_INSTALL_QMLDIR=/usr/lib/qt5/qml \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DBUILD_TESTING=OFF
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}

