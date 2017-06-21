pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=krdc
pkg_version=${_kdever}
#pkg_version=16.03.70
pkg_description='Desktop Sharing Client'
pkg_upstream_url='http://kde.org/applications/internet/krdc/'
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('kconfig' 'kcmutils' 'kdnssd' 'knotifyconfig' 'knotifications' 'kbookmarks' 'kiconthemes'
         'kxmlgui' 'kcompletion' 'kwallet' 'kwidgetsaddons' 'ki18n' 'freerdp')
         # not ported yet/removed? 'telepathy-qt5')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'libvncserver')
optpkg_deps=('libvncserver: VNC support')
pkg_source=("$_mirror/${pkg_name}-${_kdever}.tar.xz")
pkg_shasum=(`grep ${pkg_name}-${_kdever}.tar.xz ../kde-sc.md5 | cut -d" " -f1`)
#pkg_source=("git://anongit.kde.org/krdc.git")
#pkg_shasum=('SKIP')

do_prepare() {
  cd ${pkg_name}-${pkg_version}

  #sed -i -e 's|V4.2-Based Variant V1.1//EN" "dtd/kdex.dtd"|V4.5-Based Variant V1.1//EN" "dtd/kdedbx45.dtd"|' ${CACHE_PATH}/${pkg_name}/doc/index.docbook
}

do_build() {
  mkdir build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DLIB_INSTALL_DIR=lib \
    -DPLUGIN_INSTALL_DIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=OFF \
    -DHAVE_XFREERDP=ON
  make
}

do_package() {
  cd build
  
  make DESTDIR=$pkg_prefix install
}
