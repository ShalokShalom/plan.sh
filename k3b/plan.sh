pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=k3b
pkg_version=${_kdever}
epoch=1
pkg_description="Feature-rich and easy to handle CD burning application"
pkg_upstream_url="http://k3b.sourceforge.net/"
pkg_deps=('karchive' 'kconfig' 'ki18n' 'kcmutils' 'kcoreaddons' 'knotifyconfig' 'solid'
         'kfilemetadata' 'kiconthemes' 'kjobwidgets' 'kio' 'knotifications' 'knewstuff' 
         'kservice' 'kwidgetsaddons' 'kxmlgui' 'libkcddb5' 'libsamplerate' 
         'libmad' 'ffmpeg' 'taglib' 'libmpcdec' 'libdvdread' 'cdrdao' 'cdrtools' 
         'shared-mime-info' 'libxft' 'qt5-webkit' 'libburn')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'pkg-config' 'dvd+rw-tools')
optpkg_deps=('dvd+rw-tools: for dvd burning support'
            'vcdimager:    for vcd burning support'
            'emovix:       for bootable multimedia cd/dvd support'
            'cdparanoia:   for cd ripping support')
pkg_license=('GPL')
pkg_source=($_mirror/${pkg_name}-${_kdever}.tar.xz)
pkg_shasum=(`grep ${pkg_name}-${_kdever}.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_prepare() {
  cd ${pkg_name}-${pkg_version}
  #patch -p1 -i ${CACHE_PATH}/k3b-fix-mp3decoder.diff
  #sed -i -e 's|set(TAGLIB_MIN_VERSION "1.4")|set(TAGLIB_MIN_VERSION "1.10")|' cmake/modules/FindTaglib.cmake 
}

do_build() {
  mkdir -p build
  cd build

  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
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

