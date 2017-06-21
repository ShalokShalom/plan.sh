pkg_origin=cosmos

pkg_name=python3-httplib2
pkg_version=0.10.3
pkg_description="Comprehensive HTTP client library, httplib2.py supports many features left out of other HTTP libraries"
pkg_upstream_url="https://github.com/httplib2"
pkg_license=('LGPL')
pkg_deps=('python3-setuptools')
pkg_source=("https://github.com/httplib2/httplib2/archive/v${pkg_version}.tar.gz")
pkg_shasum=('1be116cd19035de6de0de0f3027c643d')

do_build() {
  
  python3 setup.py build
}

do_package() {
  python3 setup.py install --skip-build --prefix=/usr --root=${CACHE_PATH}
  
  install -Dm644 LICENSE "$CACHE_PATH/usr/share/licenses/$pkg_name/LICENSE"
}
