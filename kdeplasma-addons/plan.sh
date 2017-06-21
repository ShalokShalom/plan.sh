pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kdeplasma-addons
pkg_version=${_plasmaver}
pkg_description="KDE Plasma Addons"
pkg_upstream_url="http://www.kde.org/"
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('kactivities' 'kconfig' 'kconfigwidgets' 'kcoreaddons' 'ki18n' 'kio' 'kcmutils' 'plasma-framework' 
         'krunner' 'kservice' 'kunitconversion' 'kdelibs4support' 'knewstuff' 'kross' 
         'plasma-workspace' 'phonon-qt5' 'qca-qt5' 'purpose')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
#pkg_source=("http://download.kde.org/stable/plasma/${pkg_version}/${pkg_name}-${pkg_version}.tar.xz"
pkg_source=("${pkg_name}-${pkg_version}.tar.gz::https://github.com/KDE/${pkg_name}/archive/${_branch}.tar.gz"
        'notes.diff'
        'metadata.desktop')
pkg_shasum=(`grep ${pkg_name}-${_plasmaver}.tar.gz ../kf5.md5 | cut -d" " -f1`
         '4292d451d1e72fc0464355e2c3b0afa3'
         '80d8ea43dfb1e34accc407cc72c0395b')

do_prepare() {
  cd ${pkg_name}-${__pkg_version}
  
  patch -p1 -i ${CACHE_PATH}/notes.diff
  
  #cp ${CACHE_PATH}/metadata.desktop applets/activitypager/
}

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${__pkg_version} \
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

