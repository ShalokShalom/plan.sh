pkg_origin=

pkg_name=kproperty
pkg_version=3.0.1
_commit=fa50fe7b02e178f30695d9866a8d4a7c7845821e
pkg_description="Property editing framework with editor widget similar to what is known from Qt Designer."
pkg_upstream_url='https://github.com/KDE/kproperty'
pkg_license=('LGPL')
pkg_deps=('kconfig' 'kcoreaddons' 'kwidgetsaddons' 'kguiaddons' 'ki18n') # 'kio'
pkg_build_deps=('extra-cmake-modules')
#pkg_source=("https://github.com/KDE/kproperty/archive/${_commit}.zip")
pkg_source=("http://download.kde.org/stable/kproperty/src/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('c35b42abde40bf249da5224ce67f08b0')

do_prepare() {
  cd $pkg_name-${pkg_version}
  #sed -i -e 's|#include <baloo/completionproposal.h>||' ${CACHE_PATH}/${_pkg_name}/src/querybuilder.cpp
}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_SYSCONFDIR=/etc \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DKDE_INSTALL_LIBDIR=lib
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}
