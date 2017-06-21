pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=pykde5
#pkg_version=${_kdever}
pkg_version=4.90.81
pkg_description="Python bindings for KDE 5"
pkg_upstream_url="https://projects.kde.org/projects/kde/kdebindings/python/pykde5"
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('pyqt5-python3' 'sip3' 'kauth' 'kitemmodels' 'kitemviews' 'karchive' 'kplotting' 'solid'
         'kcoreaddons' 'sonnet' 'kguiaddons' 'kwidgetsaddons')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'git')
#groups=("kde" "kdebindings" "kde-uninstall")
#options=('docs' 'debug')
#pkg_source=("$_mirror/${pkg_name}-$_kdever.tar.xz")
#pkg_shasum=(`grep ${pkg_name}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`) 
pkg_source=("git://anongit.kde.org/pykde5")
pkg_shasum=('SKIP')

do_build() {
  mkdir -p build
  cd build

  cmake ../${pkg_name} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DLIB_INSTALL_DIR=lib \
    -DSYSCONF_INSTALL_DIR=/etc \
    -DQML_INSTALL_DIR=/usr/lib/qt5/qml \
    -DPLUGIN_INSTALL_DIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DPYTHON_EXECUTABLE=/usr/bin/python3 
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}

