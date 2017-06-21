pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=messagelib
pkg_version=${_kdever}
pkg_description="All libs for messages"
pkg_upstream_url='https://github.com/KDE/messagelib'
pkg_license=('LGPL')
pkg_deps=('akonadi' 'ki18n' 'kmime' 'akonadi-mime' 'akonadi-notes' 'kdepim-apps-libs' 'libkdepim' 'karchive' 
         'kldap' 'kpimtextedit' 'kmailtransport' 'kidentitymanagement' 'kdewebkit' 'kiconthemes'
         'kcompletion' 'kcodecs' 'kconfig' 'kxmlgui' 'akonadi-search' 'kcontacts' 'kmbox'  
         'libgravatar' 'grantleetheme' 'libkleo' 'pimcommon' 'grantlee' 'qtwebengine')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'boost')
pkg_source=($_mirror/${pkg_name}-${_kdever}.tar.xz)
pkg_shasum=(`grep ${pkg_name}-${_kdever}.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_prepare() {
  cd $pkg_name-${pkg_version}
  #sed -i -e 's|set(KMIME_LIB_VERSION "4.81.0")|set(KMIME_LIB_VERSION "4.80.0")|' ${CACHE_PATH}/${pkg_name}/CMakeLists.txt
  #patch -p1 -R -i $CACHE_PATH/299a04f3ad04b1a90ce895aea355ca5b9474f054.diff
}

do_build() {
  mkdir -p build
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
