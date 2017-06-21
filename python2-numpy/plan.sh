pkg_origin=cosmos

pkg_name=python2-numpy
pkg_version=1.13.0
pkg_description="Scientific tools for Python"
pkg_license=('custom')
pkg_upstream_url="http://www.numpy.org/"
pkg_deps=('lapack' 'python2-nose')
pkg_source=("https://github.com/numpy/numpy/releases/download/v${pkg_version}/numpy-${pkg_version}.tar.gz")
pkg_shasum=('39ae7fd9b6b09847cde5cd8ea0672757')

do_build() {
  export Atlas=None
  export LDFLAGS="$LDFLAGS -shared"
  
  python2 setup.py config_fc --fcompiler=gnu95 build
}

do_package() {
  python2 setup.py config_fc --fcompiler=gnu95 install --prefix=/usr --root=${CACHE_PATH} --optimize=1

  install -m755 -d ${CACHE_PATH}/usr/share/licenses/python2-numpy
  install -m644 LICENSE.txt ${CACHE_PATH}/usr/share/licenses/python2-numpy/
  
  install -m755 -d ${CACHE_PATH}/usr/include/python2.7
  ln -sf /usr/lib/python2.7/site-packages/numpy/core/include/numpy ${CACHE_PATH}/usr/include/python2.7/numpy
}
