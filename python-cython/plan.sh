pkg_origin=cosmos

pkg_name=('python2-cython' 'python3-cython')
pkgbase=cython
pkg_version=0.25.2
pkg_upstream_url="http://www.cython.org"
pkg_license=('APACHE')
pkg_build_deps=('python2-setuptools' 'python3-setuptools')
#pkg_source=("http://cython.org/release/Cython-${pkg_version}.tar.gz")
pkg_source=("https://pypi.python.org/packages/b7/67/7e2a817f9e9c773ee3995c1e15204f5d01c8da71882016cac10342ef031b/Cython-${pkg_version}.tar.gz")
pkg_shasum=('642c81285e1bb833b14ab3f439964086')

package_python2-cython() {
  pkg_deps=('python2' 'python2-setuptools')
  pkg_description="C-Extensions for Python 2"
  provides=('python2-c')
  
  python2 -O setup.py install --root=${CACHE_PATH}
}

package_python3-cython() {
  pkg_deps=('python3' 'python3-setuptools')
  pkg_description="C-Extensions for Python 3"

  python3 setup.py install --root=${CACHE_PATH}
  
  mv ${CACHE_PATH}/usr/bin/cygdb ${CACHE_PATH}/usr/bin/cygdb3
  mv ${CACHE_PATH}/usr/bin/cython ${CACHE_PATH}/usr/bin/cython3
  mv $CACHE_PATH/usr/bin/cythonize $CACHE_PATH/usr/bin/cythonize3
}
