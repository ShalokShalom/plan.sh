pkg_origin=cosmos

pkg_name=python3-six
pkg_version=1.10.0
pkg_description="Python 3 compatibility utilities"
pkg_upstream_url="http://pypi.python.org/pypi/six/"
pkg_license=('MIT')
pkg_deps=('python3')
pkg_source=("http://pypi.python.org/packages/source/s/six/six-${pkg_version}.tar.gz")
pkg_shasum=('34eed507548117b2ab523ab14b2f8b55')

do_check() {
  
  python3 setup.py check
}

do_package() {
  python3 setup.py install --root ${CACHE_PATH} --optimize=1
  
  install -Dm644 LICENSE ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
}
