pkg_origin=cosmos
 
pkg_name=python2-xlib
_pkg_name=python-xlib
pkg_version=0.19
pkg_description='A fully functional X client library for Python programs.'
pkg_upstream_url='https://github.com/python-xlib/python-xlib'
pkg_license=('GPL')
pkg_deps=('python2-six')
pkg_build_deps=('python2-setuptools')
pkg_source=("https://github.com/python-xlib/python-xlib/releases/download/${pkg_version}/${_pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('81f26828fc4ccdcfae8e95de6409d129')

do_package() {
  
  python2 setup.py install --root=${CACHE_PATH}
}
