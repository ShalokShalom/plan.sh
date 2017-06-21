pkg_origin=cosmos

pkg_name=sphinx_rtd_theme
pkg_description='ReadTheDocs.org theme for Sphinx'
pkg_version=0.1.7
pkg_upstream_url='https://pypi.python.org/pypi/sphinx_rtd_theme'
pkg_license=('MIT')
pkg_deps=('python2')
pkg_build_deps=('python2-setuptools')
pkg_source=("https://pypi.python.org/packages/source/s/sphinx_rtd_theme/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('3ffe014445195705968d899c38b305fd')

do_build() {

  python2 setup.py build
}

do_package() {
  python2 setup.py install --root=${CACHE_PATH} --optimize=1

  install -Dm644 LICENSE ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
}
