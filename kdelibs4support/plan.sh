pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kdelibs4support
pkg_version=${_kf5ver}
pkg_description='Provides code and utilities to ease the transition from kdelibs 4 to KDE Frameworks 5'
pkg_upstream_url='https://projects.kde.org/projects/frameworks/kde4support'
pkg_license=('LGPL')
pkg_deps=('kcompletion' 'kconfigwidgets' 'kconfig' 'kcrash' 'kdesignerplugin' 'kglobalaccel' 'kguiaddons' 'ki18n'
         'kiconthemes' 'kio' 'knotifications' 'kparts' 'kservice' 'ktextwidgets' 'kunitconversion' 'kwidgetsaddons'
         'kxmlgui' 'kdbusaddons' 'kded' 'kemoticons' 'kitemmodels' 'kinit'
         'libsm' 'networkmanager')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'qt5-tools' 'perl-uri')
pkg_source=("http://download.kde.org/unstable/frameworks/${pkg_version}/portingAids/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=(`grep ${pkg_name}-${_kf5ver}.tar.xz ../kf5.md5 | cut -d" " -f1`)

do_prepare() {
  cd ${CACHE_PATH}/${pkg_name}-${pkg_version}
  #sed -i -e 's|kded_networkstatus networkstatus.desktop SERVICE_TYPES kdedmodule.desktop|kded_networkstatus networkstatus.desktop|' src/solid-networkstatus/kded/CMakeLists.txt
}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_LIBEXECDIR=lib \
    -DKDE_INSTALL_SYSCONFDIR=/etc \
    -DPLUGIN_INSTALL_DIR=/usr/lib/qt5/plugins \
    -DBUILD_TESTING=OFF
  make
}

do_package() {
  cd build
  make DESTDIR=${pkg_prefix} install
  # conflicts with kio
  #rm -r ${pkg_prefix}/usr/share/doc/HTML/*/kcontrol5
}
