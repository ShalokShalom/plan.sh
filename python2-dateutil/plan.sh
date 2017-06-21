pkg_origin=cosmos

pkg_name=python2-dateutil
_pkg_name=python-dateutil
pkg_version=2.6.0
pkg_description="Provides powerful extensions to the standard datetime module"
pkg_license=('custom:PYTHON')
pkg_upstream_url="https://github.com/dateutil/dateutil"
pkg_deps=('python2' 'python2-six')
pkg_build_deps=('python2-setuptools' )
#pkg_source=("http://pypi.python.org/packages/source/p/python-dateutil/python-dateutil-${pkg_version}.tar.gz")
pkg_source=("https://github.com/dateutil/dateutil/releases/download/${pkg_version}/${_pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('6e38f91e8c94c15a79ce22768dfeca87')

do_check() {
  
  python2 updatezinfo.py
  python2 setup.py test
}

do_package() {
  python2 setup.py install --root=${CACHE_PATH} --optimize=1
  install -Dm644 LICENSE ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE

  chmod -R a+r ${CACHE_PATH}/usr/lib/python2.7/
  rm ${CACHE_PATH}/usr/lib/python2.7/site-packages/dateutil/zoneinfo/dateutil-zoneinfo.tar.gz
}

  
