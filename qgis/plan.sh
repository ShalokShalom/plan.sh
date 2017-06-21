pkg_origin=

pkg_name=qgis
_pkg_name=QGIS
pkg_version=2.90.2
_commit=7dbe4943d606b8acd879dd6ed9e38542e3ab0bab
pkg_description='Quantum GIS is a Geographic Information System (GIS) that supports vector, raster & database formats'
pkg_upstream_url='http://qgis.org/'
pkg_license=('GPL')
pkg_deps=('libmariadbclient' 'postgresql-libs' 'sqlite' 'jasper' 'curl' 'python2' 'giflib' 'gsl' 'grass'
         'cfitsio' 'qwt' 'proj' 'gdal' 'geos' 'libspatialite' 'spatialindex' 'python3-qscintilla-qt5' 
         'postgis' 'fcgi' 'qt5-svg' 'qt5-script' 'python3-six' 'python3-psycopg2' 'python3-dateutil'
         'python3-pytz' 'python3-jinja' 'python3-future' 'pyqt5-python3' 'qca-qt5' 'qtwebkit-tp'
         'python3-gdal' 'python3-numpy' 'python3-httplib2' 'python3-requests' 'qjson' 'pyyaml')
pkg_build_deps=('cmake'  'netcdf' 'sip3' 'qt5-tools') 
pkg_source=("https://github.com/qgis/QGIS/archive/${_commit}.zip")
pkg_shasum=('7720395a8d9ea1bba4057ff3617d66e7') 
         
do_prepare() {
     cd ${_pkg_name}-${_commit}
     #patch -p1 -i "$CACHE_PATH/canvas-qt-flicker.patch" 
     sed -i -e 's|qt/Qca-qt5/QtCrypto|qt5/Qca-qt5/QtCrypto|' cmake/FindQCA.cmake
     sed -i -e 's|set(QWT_LIBRARY_NAMES qwt-qt5 qwt6-qt5)|set(QWT_LIBRARY_NAMES qwt qwt6)|' cmake/FindQwt.cmake
     #sed -i -e 's|libqt5scintilla2|libqtscintilla2|' cmake/FindQScintilla.cmake
     
     sed -i 's/\(env \|\/usr\/bin\/\)python$/&3/' $(find . -iname "*.py")
}

 do_build() {
      mkdir -p build
      cd build
     
      cmake ../${_pkg_name}-${_commit} \
        -DENABLE_TESTS=OFF \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_SKIP_RPATH=ON \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DGRASS_PREFIX=/opt/grass \
        -DQGIS_MANUAL_SUBDIR=share/man \
        -DPYTHON_EXECUTABLE=/usr/bin/python3 \
        -DWITH_INTERNAL_SIX=FALSE \
        -DWITH_INTERNAL_DATEUTIL=FALSE \
        -DWITH_INTERNAL_HTTPLIB2=FALSE \
        -DWITH_INTERNAL_JINJA2=FALSE \
        -DWITH_INTERNAL_MARKUPSAFE=FALSE \
        -DWITH_INTERNAL_NOSE2=FALSE \
        -DWITH_INTERNAL_PYTZ=FALSE \
        -DWITH_QWTPOLAR=FALSE \
        -DWITH_QTWEBKIT=TRUE
     
      make
}

do_package() {
      cd build
     
      make DESTDIR=${pkg_prefix} install
     
      # install some freedesktop.org compatibility
      install -D -m644 $CACHE_PATH/${_pkg_name}-${_commit}/debian/qgis.desktop ${pkg_prefix}/usr/share/applications/qgis.desktop
      #install -m644 $CACHE_PATH/${_pkg_name}-${_commit}/debian/qbrowser.desktop ${pkg_prefix}/usr/share/applications
      install -dm755 ${pkg_prefix}/usr/share/pixmaps ${pkg_prefix}/usr/share/mimelnk/application
      for mime in $CACHE_PATH/${_pkg_name}-${_commit}/debian/mime/application/*.desktop
        do install -m644 ${mime} ${pkg_prefix}/usr/share/mimelnk/application
      done
      ln -s /usr/share/qgis/images/icons/qgis-icon.png ${pkg_prefix}/usr/share/pixmaps/qgis-icon.png
      ln -s /usr/share/qgis/images/icons/qgis-mime-icon.png ${pkg_prefix}/usr/share/pixmaps/qgis-mime-icon.png
     
      #python3 -m compileall -q ${pkg_prefix}
}
