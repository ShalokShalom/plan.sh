pkg_origin=cosmos

pkg_name=python2-cycler
pkg_version=0.10.0
pkg_description="Create a new Cycler object from a property name and iterable of values."
pkg_license=('BSD')
pkg_upstream_url="https://matplotlib.org/cycler/"
pkg_deps=('python2-six')
pkg_build_deps=('python2-setuptools')
pkg_source=("https://pypi.python.org/packages/source/C/Cycler/cycler-${pkg_version}.tar.gz")
pkg_shasum=('4cb42917ac5007d1cdff6cccfe2d016b')

do_build() {
  
  python setup.py build
}

do_package() {
  
  python2 setup.py install --root="${CACHE_PATH}" --optimize=1
}
