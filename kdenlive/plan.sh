pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kdenlive
pkg_version=${_kdever}
pkg_description="A non-linear video editor for Linux"
pkg_upstream_url="http://www.kdenlive.org/"
pkg_license=('GPL')
pkg_deps=('karchive' 'kbookmarks' 'kcoreaddons' 'kconfig' 'kconfigwidgets' 'kdbusaddons' 'kio'
         'kservice' 'kwidgetsaddons' 'kplotting' 'knotifyconfig' 'knewstuff' 'kxmlgui' 'knotifications'
         'kguiaddons' 'ktextwidgets' 'kiconthemes' 'kfilemetadata'
         'mlt' 'dvgrab' 'frei0r-plugins' 'qimageblitz' 'qtwebkit-tp') 
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'gettext' 'docbook-xsl')
optpkg_deps=("dvdauthor: for creating dvds")
pkg_source=("$_mirror/${pkg_name}-$_kdever.tar.xz"
        "https://cgit.kde.org/kdenlive.git/patch/?id=8a20fca86e9e2ce3d04b3e024b0752e19f9d8c8e") 
pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`
         'f8a7398628108c736df294a6ed446c6a')

do_prepare() {
  cd ${pkg_name}-${pkg_version}

  #patch -p1 -i ${CACHE_PATH}/?id=8a20fca86e9e2ce3d04b3e024b0752e19f9d8c8e
}

do_build() {
  mkdir -p build
  cd build

  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_SYSCONFDIR=/etc \
    -DKDE_INSTALL_QMLDIR=/usr/lib/qt5/qml \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF 
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}
