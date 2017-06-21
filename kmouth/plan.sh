pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kmouth
#pkg_version=${_kdever}
pkg_version=1.2.1
_commit=99e0b06b2b444e73627dba5234efa615a1e4b2f1
pkg_description="Speech synthesizer"
pkg_upstream_url="https://github.com/KDE/kmouth/"
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('ki18n' 'kcrash' 'kcompletion' 'kconfig' 'kconfigwidgets' 'kcoreaddons' 'kio' 'kwidgetsaddons' 'kxmlgui' 
         'qt5-speech' 'speech-dispatcher')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
#pkg_source=($_mirror/${_pkg_name}-$_kdever.tar.xz)
#pkg_shasum=(`grep ${_pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)
pkg_source=("https://github.com/KDE/kmouth/archive/${_commit}.zip")
pkg_shasum=('ddb34b5df4bf2cd4d0a14f70e372da6c')

do_build() {
  mkdir -p build
  cd build

  cmake ../${pkg_name}-${_commit} \
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
