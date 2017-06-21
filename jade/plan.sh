pkg_origin=cosmos

pkg_name=jade
pkg_version=1.2.1
_debpatch=49
pkg_description="James Clark's DSSSL Engine"
pkg_upstream_url='http://www.jclark.com/jade/'
pkg_license=('custom')
pkg_deps=('gcc-libs')
pkg_source=("ftp://ftp.jclark.com/pub/jade/jade-${pkg_version}.tar.gz"
        "http://ftp.debian.org/debian/pool/main/j/jade/jade_${pkg_version}-${_debpatch}.diff.gz")
pkg_shasum=('4239670ca6b578bff68b8c2e7cd1225f'
         'a41c70b039c4de60223e26667df84371')

do_build() {
  export CXXFLAGS="$CXXFLAGS -fpermissive"
  
  patch -p1 -i ${CACHE_PATH}/jade_${pkg_version}-${_debpatch}.diff 
  chmod 755 configure 
  
  ./configure --prefix=/usr --enable-default-catalog=/usr/share/sgml/catalog 
  make 
}

do_package() {
  
  install -d -m755 ${pkg_prefix}/usr/lib
  make prefix=${pkg_prefix}/usr install 
  
  mv ${pkg_prefix}/usr/bin/sx ${pkg_prefix}/usr/bin/sgml2xml
  install -m755 -d ${pkg_prefix}/usr/share/licenses/${pkg_name}
  install -m644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/ 
}
