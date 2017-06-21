pkg_origin=cosmos

pkg_name=python3-gdal
_pkg_name=GDAL
pkg_version=2.1.3
pkg_description="Geospatial Data Abstraction Library- python3 support"
pkg_upstream_url="https://pypi.python.org/pypi/GDAL/"
pkg_license=('MIT')
pkg_deps=('python3' 'gdal')
pkg_source=("https://pypi.python.org/packages/36/d7/f89ac1347185db56939c156330efbfa2e3be560060b74e31f41e514ee627/${_pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('519bff3c56b8af5dbf388f93947b1281')

do_build() {
  
  python3 setup.py build
}

do_package() {
  
  python3 setup.py install --skip-build --prefix=/usr --root=${CACHE_PATH}
}
