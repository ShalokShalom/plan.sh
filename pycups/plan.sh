pkg_origin=cosmos

pkg_name=pycups
pkg_version=1.9.73
pkg_description="Python CUPS Bindings"
pkg_upstream_url="http://cyberelk.net/tim/software/pycups/"
pkg_license=('GPL')
pkg_deps=('libcups' 'python3')
pkg_source=("http://cyberelk.net/tim/data/pycups/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('ee0e7204d7a2ae942e2f4c4508afdbfb')

do_build() {
  
  python3 setup.py build
}

do_package() {
  
  python3 setup.py install --root=${CACHE_PATH} --optimize=1
}
