pkg_origin=cosmos

pkg_name=python3-lazy-object-proxy
pkg_version=1.3.1
pkg_description="A fast and thorough lazy object proxy."
pkg_upstream_url="https://github.com/ionelmc/python-lazy-object-proxy"
pkg_license=('BSD')
pkg_deps=('python3')
pkg_build_deps=('python3-setuptools')
pkg_source=("https://pypi.python.org/packages/55/08/23c0753599bdec1aec273e322f277c4e875150325f565017f6280549f554/lazy-object-proxy-${pkg_version}.tar.gz")
pkg_shasum=('e128152b76eb5b9ba759504936139fd0')


do_build() {
  
  python3 setup.py build
}

do_package() {

  python3 setup.py install --optimize=1 --skip-build --prefix=/usr --root=${CACHE_PATH}
  install -Dm644 LICENSE ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
}
