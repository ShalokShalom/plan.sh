pkg_origin=cosmos
 
pkg_name=ipython2
_pkg_name=ipython
pkg_version=4.2.0
pkg_description="An enhanced Interactive Python shell, python2 version"
pkg_upstream_url="http://ipython.org"
pkg_license=('BSD')
pkg_deps=('python2' 'sqlite' 'python2-setuptools' 'python2-nose' 'sip' 'python2-pygments' 
         'python2-jinja' 'python2-traitlets') 
#pkg_source=("https://pypi.python.org/packages/source/i/ipython/${_pkg_name}-${pkg_version}.tar.gz")
pkg_source=("https://github.com/ipython/ipython/archive/${pkg_version}.tar.gz")
pkg_shasum=('9432d4758961501bf5f33adde08a9e6e')

do_package() {
  python2 setup.py install --prefix=/usr --root=${pkg_prefix} --optimize=0

  find ${pkg_prefix}/ -name '*.pyc' -delete
  install -Dm644 docs/source/about/license_and_copyright.rst ${pkg_prefix}/usr/share/licenses/ipython2/LICENSE

  install -Dm644 ipython.desktop ${pkg_prefix}/usr/share/applications/ipython2.desktop
}
