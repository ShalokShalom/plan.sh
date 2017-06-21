pkg_origin=cosmos

pkgbase=isodate
pkg_name=('python2-isodate' 'python3-isodate')
pkg_version=0.5.4
pkg_description="An ISO 8601 date/time/duration parser and formater"
pkg_upstream_url="http://pypi.python.org/pypi/isodate"
pkg_license=('BSD')
pkg_build_deps=('python2' 'python3')
pkg_source=("http://pypi.python.org/packages/source/i/isodate/$pkgbase-$pkg_version.tar.gz")
pkg_shasum=('9da3ea2af54a6261d854e73d2266030e')

package_python2-isodate() {
  pkg_deps=('python2')

  python2 setup.py install --root="$CACHE_PATH/" --optimize=0
  install -d "${CACHE_PATH}/usr/share/licenses/${pkg_name}"
  head -26 src/isodate/isodates.py > "${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE"
}

package_python3-isodate() {
  pkg_deps=('python3')

  python3 setup.py install --root="$CACHE_PATH/" --optimize=0
  install -d "${CACHE_PATH}/usr/share/licenses/${pkg_name}"
  head -26 src/isodate/isodates.py > "${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE"
}
