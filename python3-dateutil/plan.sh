pkg_origin=cosmos

pkg_name=python3-dateutil
_pkg_name=python-dateutil
pkg_version=2.6.0
pkg_description="Provides powerful extensions to the standard datetime module"
pkg_license=('custom:PYTHON')
pkg_upstream_url="https://github.com/dateutil/dateutil"
pkg_deps=('python3' 'python3-six')
pkg_build_deps=('python3-setuptools' )
pkg_source=("https://github.com/dateutil/dateutil/releases/download/${pkg_version}/${_pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('6e38f91e8c94c15a79ce22768dfeca87')

do_check() {
  
  python3 updatezinfo.py
  python3 setup.py test
}

do_package() {
  python3 setup.py install --root=${CACHE_PATH} --optimize=1
  install -Dm644 LICENSE ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE

  chmod -R a+r ${CACHE_PATH}/usr/lib/python3.6/
  rm ${CACHE_PATH}/usr/lib/python3.6/site-packages/dateutil/zoneinfo/dateutil-zoneinfo.tar.gz
}

  
