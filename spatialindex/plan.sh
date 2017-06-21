pkg_origin=cosmos

pkg_name=spatialindex
pkg_version=1.8.5
pkg_description="Extensible framework that will support robust spatial indexing methods."
pkg_upstream_url="http://libspatialindex.github.com/"
pkg_license=('MIT')
pkg_deps=('gcc-libs')
pkg_source=("http://download.osgeo.org/libspatialindex/${pkg_name}-src-${pkg_version}.tar.gz"
        'LICENSE')
pkg_shasum=('4065c6218ce3d1c4906beb3a313470db'
         '6a9a7d8158edbf1529ca46aae5a76752')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_check() {
  
  make -k check
}

do_package() {
  make DESTDIR=${CACHE_PATH}/ install
  
  install -D -m644 ${CACHE_PATH}/LICENSE ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
}

