pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=khtml
pkg_version=${_kf5ver}
pkg_description='Web rendering engine, based on the KParts technology and using KJS for JavaScript support.'
pkg_upstream_url='https://projects.kde.org/projects/frameworks/khtml'
pkg_license=('LGPL')
pkg_deps=('phonon-qt5' 'giflib' 'karchive' 'kcodecs' 'kglobalaccel' 'ki18n' 'kiconthemes'
         'kio' 'kparts' 'qt5-x11extras')
pkg_build_deps=('extra-cmake-modules' 'gperf')
pkg_source=("https://download.kde.org/unstable/frameworks/${pkg_version}/portingAids/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=(`grep ${pkg_name}-$_kf5ver.tar.xz ../kf5.md5 | cut -d" " -f1`)

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_SYSCONFDIR=/etc \
    -DECM_MKSPECS_INSTALL_DIR=/usr/lib/qt5/mkspecs/modules \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DBUILD_TESTING=OFF
  make
}

do_package() {
  cd build
  
  make DESTDIR="${pkg_prefix}" install
}
