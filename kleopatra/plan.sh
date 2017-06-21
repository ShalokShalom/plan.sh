pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kleopatra
pkg_version=${_kdever}
pkg_description="Certificate manager and GUI for OpenPGP and CMS cryptography."
pkg_upstream_url='https://projects.kde.org/projects/kde/pim/kleopatra'
pkg_license=('LGPL')
pkg_deps=('gnupg' 'pinentry' 'gpgme' 'kmime' 'kcodecs' 'kdbusaddons' 'kcmutils' 'kconfig'
         'ki18n' 'kiconthemes' 'knotifications' 'kxmlgui' 'kwindowsystem' 'ktextwidgets'
         'libkleo')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'boost')
pkg_source=("http://download.kde.org/stable/applications/${_kdever}/src/${pkg_name}-${_kdever}.tar.xz")
pkg_shasum=(`grep ${pkg_name}-${_kdever}.tar.xz ../kde-sc.md5 | cut -d" " -f1`)
#pkg_source=("git://anongit.kde.org/kleopatra.git")
#pkg_shasum=('SKIP')

#do_prepare() {
#  cd $pkg_name-${pkg_version}
  #patch -p1 -i $CACHE_PATH/qt55.diff
#}

do_build() {
  mkdir build
  cd build 
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_SKIP_RPATH=ON \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DQML_INSTALL_DIR=/usr/lib/qt5/qml \
    -DPLUGIN_INSTALL_DIR=/usr/lib/qt5/plugins \
    -DBUILD_TESTING=OFF 
  make 
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
