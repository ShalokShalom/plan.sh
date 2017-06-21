pkg_origin=cosmos

pkg_name=python3-nose
_pkg_name=nose
pkg_version=1.3.7
pkg_description="A discovery-based unittest extension"
pkg_upstream_url="https://pypi.python.org/pypi/nose"
pkg_license=('LGPL2')
pkg_deps=('python3-setuptools')
pkg_source=("https://pypi.python.org/packages/source/n/${_pkg_name}/${_pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('4d3ad0ff07b61373d2cefc89c5d0b20b')

do_build() {
  
  sed -i -e "s:man/man1:share/man/man1:g" setup.py
}

do_package() {
  
  python3 setup.py install --prefix=/usr --root=${CACHE_PATH}
  # conflcits with pyhton2-nose, keep there for now
  rm ${CACHE_PATH}/usr/bin/nosetests
  rm -r ${CACHE_PATH}/usr/share
}

