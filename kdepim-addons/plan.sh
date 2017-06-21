pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kdepim-addons
pkg_version=${_kdever}
pkg_description="Addons for kdepim apps (as kmail addons/ kmail theme/ kaddressbook addons etc.)"
pkg_upstream_url="https://github.com/KDE/kdepim-addons"
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('libkgapi' 'qtwebengine' 'boost-libs'
         #frameworks
         'ki18n' 'khtml' 'kconfig' 'kdbusaddons' 'kxmlgui' 'kdeclarative' 
         #kdepimlibs
         'mailcommon' 'kdepim-apps-libs' 'libkleo' 'grantleetheme'
         'pimcommon' 'libkdepim' 'incidenceeditor' 'ktnef'
         'messagelib' 'calendarsupport' 'eventviews' 'akonadi' 'libgravatar' 'libksieve')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'clang' 'boost')
pkg_source=($_mirror/${pkg_name}-${_kdever}.tar.xz)
pkg_shasum=(`grep ${pkg_name}-${_kdever}.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_prepare() {
  cd $pkg_name-${pkg_version}
  #sed -i 's|add_subdirectory(korganizer)|#add_subdirectory(korganizer)|' ${CACHE_PATH}/$pkg_name/CMakeLists.txt
  # fix license issue
  #patch -p1 -i ${CACHE_PATH}/ad9b246409bf9fbea70f57a69b4cfef1ca45c2b3.diff
}

do_build() {
  mkdir build
  
  export CC=/usr/bin/clang
  export CXX=/usr/bin/clang++
  
  cd build 
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_LIBEXECDIR=lib \
    -DKDE_INSTALL_SYSCONFDIR=/etc \
    -DKDE_INSTALL_QMLDIR=/usr/lib/qt5/qml \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=FALSE \
    -DKDEPIMADDONS_BUILD_EXAMPLES=TRUE
  make 
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
