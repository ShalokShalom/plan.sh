pkg_origin=

pkg_name=kexi
pkg_version=3.0.1.1
_pkg_version=3.0.1
pkg_description="Visual database applications creator"
pkg_upstream_url='http://kexi-project.org/'
pkg_license=('FDL1.2' 'GPL2' 'LGPL')
pkg_deps=('karchive' 'kcodecs' 'kcompletion' 'kconfig' 'kconfigwidgets' 'kcoreaddons' 
         'kguiaddons' 'ki18n' 'kiconthemes' 'kitemviews' 'kio' 'ktexteditor' 'ktextwidgets' 
         'kwidgetsaddons' 'kxmlgui' 'marble' 'breeze-icons'
         'kproperty' 'kreport' 'kdb'
         'libmariadbclient' 'sqlite3' 'qtwebkit-tp' 'freetds' 'postgresql') # will switch to qtwebengine
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'git' 'qt5-tools') # 'clang') 
pkg_source=("http://download.kde.org/stable/kexi/src/${pkg_name}-${pkg_version}.tar.xz")
#pkg_source=("https://github.com/KDE/kexi/archive/${_commit}.zip")
pkg_shasum=('40523d9165832e7d752696778dbd5a5a')

do_prepare() {
  cd ${pkg_name}-${_pkg_version}
  
  #patch -p1 -i $CACHE_PATH/desktop_files.patch
}

do_build() {
  mkdir build
  cd build
  
  #export CC=/usr/bin/clang
  #export CXX=/usr/bin/clang++
  
  cmake ../${pkg_name}-${_pkg_version} \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DBUILD_TESTING=FALSE 
  make
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}

