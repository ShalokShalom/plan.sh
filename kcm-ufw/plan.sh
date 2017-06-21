pkg_origin=

pkg_name=kcm-ufw
pkg_version=0.4.3
pkg_description="UFW KControl Module"
pkg_upstream_url="http://kde-apps.org/content/show.php/UFW+KControl+Module?content=137789"
pkg_license=('GPL')
pkg_deps=('ufw' 'kde-workspace' 'python2' 'openssl' 'polkit-kde-agent')
pkg_build_deps=('automoc4' 'cmake' 'docbook-xsl')
pkg_source=("http://craigd.wikispaces.com/file/view/kcm_ufw-$pkg_version.tar.bz2")
pkg_shasum=('97de867481948e3f54d76ca3678ffd2e')

do_build() {
  cd "${CACHE_PATH}/kcm_ufw-${pkg_version}/"

  mkdir build
  cd build
  cmake  -DCMAKE_INSTALL_PREFIX=/usr ..
  make
}

do_package() {
  cd "${CACHE_PATH}/kcm_ufw-${pkg_version}/build"
  
  make DESTDIR="${pkg_prefix}" install 
}
