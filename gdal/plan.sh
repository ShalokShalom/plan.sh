pkg_origin=cosmos

pkg_name=gdal
pkg_version=2.2.0
pkg_description="A translator library for raster geospatial data formats"
pkg_upstream_url="http://www.gdal.org/"
pkg_license=('custom')
pkg_deps=('curl' 'geos' 'giflib' 'hdf5' 'libgeotiff' 'libjpeg-turbo' 'libpng' 'libtiff' 'netcdf'
         'poppler' 'python2-numpy' 'sqlite3' 'mariadb' 'postgresql-libs' 'cfitsio'
         'libspatialite' 'unixodbc')
pkg_build_deps=('perl' 'swig')
pkg_source=("https://download.osgeo.org/gdal/${pkg_version}/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('37d98d32d6ab0b2d7026a6089c3d17ba')

do_build() {
  export CFLAGS="$CFLAGS -fno-strict-aliasing"
  export LDFLAGS="$LDFLAGS -Wl,--as-needed"


  ./configure --prefix=/usr --with-netcdf --with-libtiff --with-sqlite3 \
              --with-geotiff --with-mysql --with-python --with-curl \
              --with-hdf5 --with-perl --with-geos --with-png \
              --with-poppler --with-spatialite

  sed -i 's/PY_HAVE_SETUPTOOLS=1/PY_HAVE_SETUPTOOLS=/g' ./GDALmake.opt
  sed -i 's/EXE_DEP_LIBS/KILL_EXE_DEP_LIBS/' apps/GNUmakefile
  #install -d ${pkg_prefix}/usr/lib/python2.7/site-packages/

  make
}

package () {
  make DESTDIR=${pkg_prefix} install

  install -D -m644 LICENSE.TXT ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
  rm -f ${pkg_prefix}/usr/bin/*.dox
}
