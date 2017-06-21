pkg_origin=

pkg_name=kdeplasma-applets-yawp
pkg_version=0.4.5
pkg_description="A Colorful Kdeplasma weather plasmoid"
pkg_upstream_url="http://www.kde-look.org/content/show.php/yaWP+(Yet+Another+Weather+Plasmoid)?content=94106"
pkg_deps=('kde-workspace' 'gettext')
pkg_build_deps=('cmake' 'make' 'automoc4' 'patch')
install=$pkg_name.install
pkg_source=("http://downloads.sourceforge.net/yawp/yawp-$pkg_version.tar.bz2")
pkg_license=('GPL')
pkg_shasum=('4ceb65c370107409fc07c430bd5a9822')

do_build() {
  cd $CACHE_PATH/yawp-$pkg_version
  mkdir build
  
  cd build
  cmake -DCMAKE_INSTALL_PREFIX=`kde4-config --prefix` .. 
  make VERBOSE=1 
}

do_package() {
  cd $CACHE_PATH/yawp-$pkg_version/build
  
  make DESTDIR=$pkg_prefix install 
}
