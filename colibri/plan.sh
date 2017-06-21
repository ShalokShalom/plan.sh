pkg_origin=

pkg_name=colibri
pkg_version=0.3.0
pkg_description="Colibri provides an alternative to KDE4 Plasma notifications."
pkg_upstream_url="http://kde-apps.org/content/show.php/Colibri?content=117147"
pkg_license=('GPL')
pkg_deps=('kde-workspace')
pkg_build_deps=('gcc' 'cmake' 'automoc4')
install=colibri.install
pkg_source=("http://download.kde.org/stable/${pkg_name}/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('6b39ca00645d8557886577e1366deecd')
 
do_build() {
  cd $CACHE_PATH/${pkg_name}-${pkg_version}
  mkdir build 

  cd build
  cmake -DCMAKE_INSTALL_PREFIX=`kde4-config --prefix` ../
  make
}

do_package() {
  cd $CACHE_PATH/${pkg_name}-${pkg_version}/build

  make DESTDIR="$pkg_prefix/" install
}

