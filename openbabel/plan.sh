pkg_origin=cosmos

pkg_name=openbabel
pkg_version=2.4.1
pkg_description="Open, collaborative project allowing anyone to search, convert,
         analyze, or store data from molecular modeling, chemistry, solid-state materials,
         biochemistry, or related areas"
pkg_upstream_url="http://openbabel.sourceforge.net/"
pkg_license=('GPL')
pkg_deps=('gcc-libs' 'libxml2' 'eigen3' 'cairo')
pkg_build_deps=('cmake')
pkg_source=("http://downloads.sourceforge.net/openbabel/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('d9defcd7830b0592fece4fe54a137b99')

prepare() {
  
  #sed -i -e 's|if __GNUC__ == 4  //&&|if __GNUC__ >= 4  //&&|' include/openbabel/shared_ptr.h
}

do_build() {
  mkdir -p build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
