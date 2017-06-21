pkg_origin=cosmos

pkg_name=python3-pycurl
_pkg_name=pycurl
pkg_version=7.43.0
_pkg_version=REL_7_43_0
pkg_description="A Python interface to libcurl."
pkg_upstream_url="http://pycurl.sourceforge.net"
pkg_license=('GPL3')
pkg_deps=('python3' 'curl')
pkg_source=("https://github.com/pycurl/pycurl/archive/$_pkg_version.tar.gz")
pkg_shasum=('a574843ff1e7781e41e552574855c073')

do_build() {
  
  make PYTHON=python3.6
  python3 setup.py build --with-ssl
}

do_package() {
  
  python3 setup.py install -O1 --root=${CACHE_PATH}
  install -D -m644 COPYING-MIT ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
}
