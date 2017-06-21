pkg_origin=

pkg_name=shared-desktop-ontologies
pkg_version=0.10.0
pkg_description="Ontologies necessary for the Nepomuk semantic desktop"
pkg_upstream_url="http://sourceforge.net/apps/trac/oscaf/"
pkg_license=('GPL')
pkg_build_deps=("cmake")
pkg_source=("http://downloads.sourceforge.net/oscaf/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('bfb7b5acbb43e5e45466c87dbe9c45b7')

do_build() {
  cd "${CACHE_PATH}"
  
  mkdir build
  cd build
  cmake "../${pkg_name}-${pkg_version}" \
    -DCMAKE_INSTALL_PREFIX=/usr 
  make 
}

do_package() {
  cd "${CACHE_PATH}/build"
  
  make DESTDIR="${pkg_prefix}" install
}
