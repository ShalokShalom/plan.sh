pkg_origin=cosmos

pkg_name=tinyxml2
pkg_version=4.0.1
pkg_description='Simple, small, C++ XML parser that can be easily integrated into other programs, follow up for tinyxml'
pkg_upstream_url="http://www.grinninglizard.com/tinyxml2/"
pkg_license=('zlib')
pkg_deps=('gcc-libs')
pkg_source=("https://github.com/leethomason/tinyxml2/archive/${pkg_version}.tar.gz")
pkg_shasum=('36aed868b751e728fa8f714aa3376a1d')

do_build() {  
  mkdir -p build

  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_INSTALL_LIBDIR=lib 
  make
}

do_package() {

  make DESTDIR=${CACHE_PATH} install
}

