pkg_origin=

pkg_name=postgis
pkg_version=2.3.2
pkg_description="Adds support for geographic objects to PostgreSQL"
pkg_upstream_url="http://postgis.refractions.net/"
pkg_license=('GPL')
pkg_deps=('postgresql' 'proj' 'geos' 'gdal' 'json-c')
pkg_source=("http://download.osgeo.org/postgis/source/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('3b1a648d0c15bce5bd18ec3481fc633b')

do_build() {
   cd ${pkg_name}-${pkg_version}
   
   ./configure --prefix=/usr --with-gdalconfig=/usr/bin/gdal-config
   make
}

do_package() {
    cd ${pkg_name}-${pkg_version}
	
    make DESTDIR=${pkg_prefix} install
}
