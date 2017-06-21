pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kdepim-apps-libs
pkg_version=${_kdever}
pkg_description="This module contains mail-related libraries."
pkg_upstream_url='https://projects.kde.org/projects/kde/pim/kdepim-apps-libs'
pkg_license=('LGPL')
pkg_deps=('akonadi-contacts' 'ki18n' 'kconfig' 'kservice' 'libkleo' 'grantleetheme' 'kcontacts'
         'kxmlgui' 'kcompletion' 'sonnet' 'kmime' 'kdewebkit' 'kpimtextedit' 'pimcommon'
         'kcoreaddons' 'kdbusaddons' 'kwidgetsaddons' 'grantlee')
pkg_build_deps=('extra-cmake-modules' 'qt5-tools' 'kdoctools' 'boost')
pkg_source=("http://download.kde.org/stable/applications/${_kdever}/src/${pkg_name}-${_kdever}.tar.xz")
pkg_shasum=(`grep ${pkg_name}-${_kdever}.tar.xz ../kde-sc.md5 | cut -d" " -f1`)
#pkg_source=("git://anongit.kde.org/kdepim-apps-libs")
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
    -DKDE_INSTALL_QMLDIR=/usr/lib/qt5/qml \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DBUILD_TESTING=OFF 
  make 
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
