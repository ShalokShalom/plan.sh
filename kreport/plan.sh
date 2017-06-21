pkg_origin=

pkg_name=kreport
pkg_version=3.0.1
_commit=3c791e9bf95fea16cada9c43f74d88795a506dc8
pkg_description="Framework for creation and generation of reports in multiple formats"
pkg_upstream_url='https://github.com/KDE/kreport'
pkg_license=('LGPL')
pkg_deps=('kcoreaddons' 'kwidgetsaddons' 'kguiaddons' 'kross' 'ki18n' 'kproperty'
         'marble' 'qtwebkit-tp')
pkg_build_deps=('extra-cmake-modules' 'git')
#pkg_source=("https://github.com/KDE/kreport/archive/${_commit}.zip")
pkg_source=("http://download.kde.org/stable/kreport/src/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('8690784c0668122a721e5bf410270829')

do_prepare() {
  cd $pkg_name-${pkg_version}
  #sed -i -e 's|#include <kglobal.h>|#include <KSharedConfig>|' ${CACHE_PATH}/${pkg_name}/src/wrtembed/KReportDpi.cpp
  #sed -i -e 's|K_GLOBAL_STATIC|Q_GLOBAL_STATIC|' ${CACHE_PATH}/${pkg_name}/src/wrtembed/KReportDpi.cpp
  #patch -p1 -i $CACHE_PATH/0003-Port-from-K_GLOBAL_STATIC-to-Q_GLOBAL_STATIC.patch
}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_SYSCONFDIR=/etc \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DKDE_INSTALL_LIBDIR=lib \
    -DBUILD_TESTING=OFF
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}
