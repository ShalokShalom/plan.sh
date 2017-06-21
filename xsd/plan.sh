pkg_origin=cosmos

pkg_name=xsd
pkg_version=4.0.0
_pkg_version=4.0.0+dep
pkg_description="An open-source, cross-platform W3C XML Schema to C++ data binding compiler"
pkg_upstream_url="http://www.codesynthesis.com/products/xsd"
pkg_license=('GPL2')
pkg_deps=('boost-libs' 'xerces-c')
pkg_source=("http://www.codesynthesis.com/download/xsd/4.0/${pkg_name}-${_pkg_version}.tar.bz2"
        "xsdcxx.patch")
pkg_shasum=('ae64d7fcd258addc9b045fe3f96208bb'
         'd49e0bbd3bae200f2c6bb7e37326a6ef')

do_build() {
  patch -p1 -i ${CACHE_PATH}/xsdcxx.patch

  make 
}

do_package() {
  make install_prefix=${CACHE_PATH}/usr install

  # Fix conflicts with mono
  mv ${CACHE_PATH}/usr/bin/xsd{,cxx}
  mv ${CACHE_PATH}/usr/share/man/man1/xsd{,cxx}.1
}
