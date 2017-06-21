pkg_origin=cosmos

pkg_name=python3-lxml
pkg_version=3.8.0
pkg_description="Python3 binding for the libxml2 and libxslt libraries"
pkg_license=('BSD' 'GPL' 'custom')
pkg_upstream_url="http://lxml.de/"
pkg_deps=('python3-cython' 'libxslt')
pkg_source=("https://pypi.io/packages/source/l/lxml/lxml-${pkg_version}.tar.gz")
pkg_shasum=('e54e2fae44d684d6b9c636fe189e93ff')

do_build() {
  /bin/true
}

do_package() {

  python3 setup.py install --root=${CACHE_PATH} --optimize=1

  install -D -m644 LICENSES.txt ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE 
  install -D -m644 doc/licenses/BSD.txt ${CACHE_PATH}/usr/share/licenses/${pkg_name}/BSD.txt 
  install -D -m644 doc/licenses/elementtree.txt ${CACHE_PATH}/usr/share/licenses/${pkg_name}/elementtree.txt 
}
