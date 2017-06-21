pkg_origin=cosmos
pkg_name=vc
pkg_version=1.3.2
pkg_description="A library to ease explicit vectorization of C++ code"
pkg_upstream_url='http://code.compeng.uni-frankfurt.de/projects/vc/'
pkg_license=('LGPL3')
pkg_build_deps=('cmake')
pkg_source=("https://github.com/VcDevel/Vc/releases/download/${pkg_version}/Vc-${pkg_version}.tar.gz")
pkg_shasum=('f996a2dcab9f0ef3e21ba0d0feba9c3e')
 
do_build() {
  mkdir build 
  
  cmake ../Vc-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_TESTING=OFF
    #-DTARGET_ARCHITECTURE=core  leaving empty will use auto, other options to test are generic and amd
  make
}

#do_check() {
#  cd build

#  make test
#}

do_package() {
  
  make DESTDIR="${CACHE_PATH}" install
}

