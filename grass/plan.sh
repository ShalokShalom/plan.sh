pkg_origin=

# build twice, when building on the server, j8 fails to honor without wx first time

pkg_name=grass
pkg_version=7.2.1
pkg_description='Geographic Information System (GIS) used for geospatial data management and analysis, image processing, graphics/maps production, spatial modeling, and visualization.'
pkg_upstream_url='https://grass.itc.it/index.php'
pkg_license=('GPL')
pkg_deps=('gdal' 'tk' 'sqlite3' 'python2' 'mesa' 'proj' 'libjpeg-turbo' 'libpng' 'libtiff'
         'cfitsio' 'fftw' 'libxmu' 'postgresql' 'xorg-server' 'glu' 'tcl' 'zlib' 'cairo' 'geos')
pkg_build_deps=('mariadb' 'freetype2' 'r')
optpkg_deps=('fftw: required for i.fft and i.ifft modules'
            'postgresql: PostgreSQL database interface'
            'r: R language interface'
            'lapack: required for GMATH library')
pkg_source=("https://grass.osgeo.org/grass72/source/${pkg_name}-${pkg_version}.tar.gz"
        "${pkg_name}.sh"
        "${pkg_name}.conf")
pkg_shasum=('5c858c718d40a4f3e82741e60c9f7b97'
         '23da2e9399b3c5504851dec37821abe1'
         '6103480c2a1adc19a50b9e925e5e6d4c')

do_build() {
  cd ${pkg_name}-${pkg_version}
  sed -i '/^\s*INSTDIR/ s/".*"//' configure
  export CFLAGS="$CPPFLAGS $CFLAGS"
  export CXXFLAGS="$CPPFLAGS $CXXFLAGS"
  unset CPPFLAGS

  # see ${CACHE_PATH}/grass-6.4.0/REQUIREMENTS.html for options
  ./configure --enable-64bit \
    --prefix=/opt/grass \
    --with-mysql-includes=/usr/include/mysql \
    --with-mysql \
    --with-sqlite \
    --with-postgres \
    --with-fftw \
    --with-gdal=/usr/bin/gdal-config \
    --with-python \
    --with-blas \
    --with-lapack \
    --with-readline \
    --with-pthread \
    --with-netcdf \
    --with-nls \
    --with-geos \
    --with-cairo \
    --with-postgres \
    --with-proj-libs=/usr/lib \
    --with-proj-includes=/usr/include \
    --with-proj-share=/usr/share/proj \
    --with-fftw-includes=/usr/include \
    --with-fftw-libs=/usr/lib \
    --with-freetype \
    --with-freetype-includes=/usr/include/freetype2 \
    --without-glw \
    --without-wxwidgets \
    --without-htmldocs
   
  make -j4
}

do_package() {
  cd ${pkg_name}-${pkg_version}

  make \
    exec_prefix=$pkg_prefix/usr \
    INST_DIR=${pkg_prefix}/opt/grass \
    BINDIR=${pkg_prefix}/usr/bin \
    install

  install -D -m644 gui/icons/grass-48x48.png ${pkg_prefix}/usr/share/icons/hicolor/48x48/apps/grass.png
  install -D -m644 gui/icons/grass-64x64.png $pkg_prefix/usr/share/icons/hicolor/64x64/apps/grass.png

  install -D -m644 ${CACHE_PATH}/grass.conf ${pkg_prefix}/etc/ld.so.conf.d/grass.conf
}
