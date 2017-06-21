pkg_origin=cosmos

pkg_name=vigra
pkg_version=1.11.1
_pkg_version=1-11-1
pkg_description="Computer vision library"
pkg_upstream_url="http://hci.iwr.uni-heidelberg.de/vigra/"
pkg_license=('custom:MIT')
pkg_deps=('libpng' 'libtiff' 'gcc-libs' 'sh' 'hdf5' 'fftw' 'openexr')
pkg_build_deps=('cmake' 'python2-nose' 'doxygen' 'python2-sphinx' 'boost' 'python2-numpy')
optpkg_deps=('python2: for python bindings'
            'boost-libs: for python bindings')
pkg_source=("https://github.com/ukoethe/vigra/archive/Version-${_pkg_version}.tar.gz")
pkg_shasum=('46acc077a0cb24e41c5cb8e1f75dc148')

do_build() {
  
  cmake -DCMAKE_INSTALL_PREFIX=/usr \
      -DPYTHON_EXECUTABLE=/usr/bin/python2 \
      -DWITH_OPENEXR=1 \
      -DWITH_VIGRANUMPY=1 \
      -DDOCINSTALL=share/doc 
  make
}

do_check() {
  
  #make -k check || /bin/true 
}

do_package() {
  make DESTDIR=${CACHE_PATH} install

  install -D -m644 LICENSE.txt ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
}
