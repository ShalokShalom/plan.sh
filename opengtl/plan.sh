pkg_origin=cosmos

pkg_name=opengtl
pkg_version=0.9.18
pkg_description="A set of library for using and integrating transformation algorithms (such as filter or color conversion) in graphics applications"
pkg_upstream_url="http://www.opengtl.org"
pkg_license=('GPL')
pkg_deps=('gcc-libs' 'llvm' 'libpng')
pkg_build_deps=('cmake')
pkg_source=("http://download.opengtl.org/OpenGTL-${pkg_version}.tar.bz2"
        'opengtl-0.9.18-llvm-3.3.patch')
pkg_shasum=('8a9673c648ef5af4fcc7f60bb8282811'
         'c7c950b6a467d1a99ae90262f5647188')

do_build() {
  mkdir build
  patch -d OpenGTL-$pkg_version -p1 -i "$CACHE_PATH/opengtl-0.9.18-llvm-3.3.patch"
  
  cmake ../OpenGTL-${pkg_version} \
                -DCMAKE_BUILD_TYPE=Release \
                -DCMAKE_SKIP_RPATH=ON \
		-DCMAKE_INSTALL_PREFIX=/usr
  make
}

do_package() {
  
  make DESTDIR="${pkg_prefix}" install
}
