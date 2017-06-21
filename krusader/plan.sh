pkg_origin=

pkg_name=krusader
pkg_version=2.6.0
epoch=1
pkg_description="An alternative file manager for KDE resembling Midnight Commander"
pkg_upstream_url="http://krusader.sourceforge.net/"
pkg_license=('GPL')
pkg_deps=('karchive' 'kbookmarks' 'kcodecs' 'kcompletion' 'kconfig' 'ki18n' 'kiconthemes' 'kitemviews'
         'kio' 'knotifications' 'kparts' 'solid' 'ktextwidgets' 'kwallet' 'kwidgetsaddons'
         'kwindowsystem' 'kxmlgui' 'acl' 'ark' 'keditbookmarks' 'konsole' 'kate')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'docbook-xsl')
pkg_source=("http://download.kde.org/stable/krusader/${pkg_version}/${pkg_name}-${pkg_version}.tar.xz")
#pkg_source=("https://github.com/KDE/krusader/archive/${_commit}.zip")
pkg_shasum=('a4559041d1b6dfe0830fbe3a3029e524')

do_prepare() {
  cd ${pkg_name}-${pkg_version}

  #patch -p1 -i "$CACHE_PATH/kde_bug309119.diff" 
  #patch -p1 -i "$CACHE_PATH/kde_bug325801.diff" 
}

do_build() {
  mkdir build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_PLUGINDIR=/usr/lib/qt5/plugins \
    -DKDESU_PATH=/usr/lib/kf5/kdesu
  make 
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install 
}
