pkg_origin=

pkg_name=kdeplasma-applets-stackfolder
_pkg_name=plasma-applet-stackfolder
pkg_version=2.4
_pkg_version=2.4-7
pkg_description="Browse the stack of folders"
pkg_upstream_url="http://www.rosalab.ru"
pkg_license=('GPL')
pkg_deps=('kde-workspace' 'kde-baseapps')
pkg_build_deps=('cmake' 'automoc4')
pkg_source=("http://mirror.rosalab.ru/rosa2012.1/repository/SRPMS/main/updates/$_pkg_name-$_pkg_version.src.rpm")
pkg_shasum=('ef740d0832d390d3df3283d3e0de7087')
 
do_build() {
  cd "${CACHE_PATH}"
  tar -zxvf $_pkg_name-$pkg_version.tar.gz
  cd  $_pkg_name-$pkg_version
  
  mkdir build
  cd build
  cmake -DCMAKE_INSTALL_PREFIX=`kde4-config --prefix` ../
  make VERBOSE=1 
}
 
do_package() {
  cd "${CACHE_PATH}/$_pkg_name-$pkg_version/build"
 
  make DESTDIR="${pkg_prefix}" install
}


