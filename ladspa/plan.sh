pkg_origin=cosmos

pkg_name=ladspa
pkg_version=1.13
pkg_description="Linux Audio Developer's Simple Plugin API (LADSPA)"
pkg_license=('LGPL')
pkg_upstream_url="http://www.ladspa.org/"
pkg_deps=('gcc-libs')
pkg_source=("http://pkgs.fedoraproject.org/repo/pkgs/ladspa/ladspa_sdk_1.13.tgz/671be3e1021d0722cadc7fb27054628e/${pkg_name}_sdk_${pkg_version}.tgz"
        'hardcode-path.patch')
pkg_shasum=('671be3e1021d0722cadc7fb27054628e'
         '27743258232d828575d66940e6de2858')

do_build() {
  patch -p1 -i ${CACHE_PATH}/hardcode-path.patch
  
  sed -i -e 's|mkdirhier|mkdir -p|' makefile 
  make targets 
}

do_package() {
  
  make INSTALL_PLUGINS_DIR=${pkg_prefix}/usr/lib/ladspa/ \
       INSTALL_INCLUDE_DIR=${pkg_prefix}/usr/include/ \
       INSTALL_BINARY_DIR=${pkg_prefix}/usr/bin/ install
}
