pkg_origin=cosmos

pkg_name=alabaster
pkg_version=0.7.3
pkg_description="Configurable sidebar-enabled Sphinx theme"
pkg_upstream_url='https://pypi.python.org/pypi/alabaster'
pkg_license=('BSD')
pkg_build_deps=('python2-setuptools')
pkg_source=("https://pypi.python.org/packages/source/a/alabaster/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('67428d1383fd833f1282fed5deba0898')

do_build() {

  python2 setup.py build
}

do_package() {
  python2 setup.py install --root=$pkg_prefix --optimize=1
  
  install -Dm644 LICENSE ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
