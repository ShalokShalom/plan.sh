pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=cervisia
pkg_version=${_kdever}
#pkg_version=16.07.71
_commit=c788b78153b30a1b9bad9fd6bcc06b3a610a1b98
pkg_description='CVS GUI frontend for KDE'
pkg_upstream_url='http://kde.org/applications/development/cervisia/'
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('kparts' 'kinit' 'kiconthemes' 'knotifications' 'kwidgetsaddons' 'kitemviews' 'kdesu')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
pkg_source=("$_mirror/${pkg_name}-${_kdever}.tar.xz")
pkg_shasum=(`grep ${pkg_name}-${_kdever}.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_prepare() {
  cd ${pkg_name}-${pkg_version}

  #sed -i -e 's|V4.2-Based Variant V1.1//EN" "dtd/kdex.dtd"|V4.5-Based Variant V1.1//EN" "dtd/kdedbx45.dtd"|' ${CACHE_PATH}/${pkg_name}/doc/index.docbook
  #sed -i -e 's|#include <QRegExp>|#include <QtCore/QRegExp>|' ${CACHE_PATH}/${pkg_name}/cvsservice/cvsaskpass.cpp
}

do_build() {
  mkdir build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DLIB_INSTALL_DIR=lib \
    -DSYSCONF_INSTALL_DIR=/etc \
    -DQML_INSTALL_DIR=/usr/lib/qt5/qml \
    -DPLUGIN_INSTALL_DIR=/usr/lib/qt5/plugins \
    -DBUILD_TESTING=OFF 
  make
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
