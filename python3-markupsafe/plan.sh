pkg_origin=cosmos

pkg_name=python3-markupsafe
pkg_version=1.0
pkg_description="Implements a XML/HTML/XHTML Markup safe string for Python"
pkg_upstream_url="http://pypi.python.org/pypi/MarkupSafe"
pkg_license=('custom')
pkg_deps=('python3')
pkg_build_deps=('python3-setuptools')
pkg_source=("https://pypi.python.org/packages/4d/de/32d741db316d8fdb7680822dd37001ef7a448255de9699ab4bfcbdf4172b/MarkupSafe-${pkg_version}.tar.gz")
pkg_shasum=('2fcedc9284d50e577b5192e8e3578355')

do_check() {
  
  python3 setup.py test
}

do_package() {
  python3 setup.py install --root=${CACHE_PATH} --optimize=1

  install -D -m644 LICENSE ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
}
