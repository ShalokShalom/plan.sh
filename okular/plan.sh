pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=okular
pkg_version=${_kdever}
pkg_description="KDE document viewer"
pkg_upstream_url="http://www.kde.org"
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('kactivities' 'karchive' 'kbookmarks' 'kcompletion' 'kconfig' 'kconfigwidgets' 'kcoreaddons' # not needed 17.04.1'kdbusaddons'
         'kjs' 'kio' 'khtml' 'kparts' 'kpty' 'threadweaver' 'kiconthemes' 'kwallet' 'kwindowsystem'
         'phonon-qt5' 'libxxf86vm' 'sane' 'lcms' 'poppler-qt5' 'chmlib' 'djvulibre' 'libspectre' 'ebook-tools'
         'json-c' 'qimageblitz-qt5' 'libkexiv2' 'libkdcraw' 'kdegraphics-mobipocket' 'qt5-speech')
pkg_build_deps=('pkg-config' 'extra-cmake-modules' 'kdoctools' 'qca-qt5')
pkg_source=("$_mirror/${pkg_name}-${_kdever}.tar.xz")
pkg_shasum=(`grep ${pkg_name}-${_kdever}.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_prepare() {
  cd $pkg_name-${pkg_version}
  #patch -p1 -i $CACHE_PATH/warning.diff
  #sed -i -e 's|ecm_setup_version(0.99.|ecm_setup_version(1.0.|' CMakeLists.txt
}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF \
    -DKF5KExiv2_DIR=/usr/lib/cmake/KEXIV2
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
  # fix non-working menu item in lost & found
  echo "NoDisplay=true" >> ${pkg_prefix}/usr/share/applications/org.kde.mobile.okular.desktop
}
