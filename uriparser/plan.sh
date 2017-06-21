pkg_origin=

pkg_name=uriparser
pkg_version=0.8.4
pkg_description="Strictly RFC 3986 compliant, cross-platform, fast URI parsing library, fast, supports Unicode"
pkg_upstream_url="http://sourceforge.net/projects/uriparser/"
pkg_license=("custom")
pkg_build_deps=('doxygen' 'graphviz')
pkg_source=("https://downloads.sourceforge.net/sourceforge/uriparser/${pkg_name}-${pkg_version}.tar.bz2"
        'Makefile.diff')
pkg_shasum=('9aabdc3611546f553f4af372167de6d6'
         'c2738fa9cf521adb98552de548e02e14')

do_build() {
  cd ${pkg_name}-${pkg_version}

  ./configure --prefix=/usr --disable-test
  patch -p1 -i ${CACHE_PATH}/Makefile.diff 

  make
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  make DESTDIR=${pkg_prefix} install
  
  install -D -m644 ../${pkg_name}-${pkg_version}/COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
