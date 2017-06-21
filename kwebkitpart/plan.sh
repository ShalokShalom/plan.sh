pkg_origin=

pkg_name=kwebkitpart
pkg_version=1.3.4.1
pkg_description="A web browser component for KDE"
pkg_upstream_url="http://opendesktop.org/content/show.php?content=127960"
pkg_license=('GPL')
pkg_deps=('karchive' 'kbookmarks' 'kcoreaddons' 'kconfig' 'kconfigwidgets' 'kdbusaddons' 'kio'
         'kdelibs4support' 'kparts' 'kactivities' 'kdewebkit' 'ki18n' 'qt5-webkit')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'git' 'qt5-tools')
#pkg_source=("http://sourceforge.net/projects/kdeos/files/Sources/${pkg_name}/${pkg_name}-${pkg_version}.tar.bz2")
pkg_source=("git://anongit.kde.org/kwebkitpart.git#branch=frameworks")
pkg_shasum=('SKIP')

do_build() {
  mkdir build
  cd build
  
  cmake ../${pkg_name} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DLIB_INSTALL_DIR=lib \
    -DPLUGIN_INSTALL_DIR=/usr/lib/qt5/plugins/kf5/parts \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF 
  make
}

do_package() {
  cd build
  
  make DESTDIR=$pkg_prefix install
}
