pkg_origin=cosmos

pkg_name=python3-future
_pkg_name=python-future
pkg_version=0.16.0
pkg_description="Easy, clean, reliable Python 2/3 compatibility"
pkg_upstream_url="http://python-future.org/"
pkg_license=('MIT')
pkg_deps=('python3-setuptools')
pkg_source=("https://github.com/PythonCharmers/python-future/archive/v${pkg_version}.tar.gz")
pkg_shasum=('f90a7fe297c6bd0003fba23b7c5e2957')

do_build() {
  
  python3 setup.py build
}

do_package() {
  python3 setup.py install --skip-build --prefix=/usr --root=${CACHE_PATH}
  
  install -Dm644 LICENSE.txt ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE.txt
}
