pkg_origin=cosmos

pkg_name=shapelib
pkg_version=1.4.0
pkg_description='Simple C API for reading and writing ESRI Shapefiles'
pkg_upstream_url='http://shapelib.maptools.org/'
pkg_license=('LGPL' 'MIT')
pkg_deps=('proj')
pkg_source=("http://download.osgeo.org/shapelib/${pkg_name}-${pkg_version}.tar.gz"
        'LICENSE')
pkg_shasum=('90cdfdc8aedce63fc689d7bfae453879'
         'ab2b25e10a8b30c88e4c0fd4862d0a5b')

do_build() {
  #sed -i -e s:'-fPIC':"${CFLAGS} -fPIC": Makefile
  
  ./configure --prefix=/usr
  make
}

do_package() {
  make DESTDIR=${CACHE_PATH} install
  
  #chmod 644 ${CACHE_PATH}/usr/include/shapefil.h
  install -D -m644 COPYING ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
}
