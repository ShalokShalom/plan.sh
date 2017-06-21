pkg_origin=cosmos

pkg_name=python2-cairo
_pkg_name=pycairo
pkg_version=1.13.3
pkg_description="Python bindings for the cairo graphics library"
pkg_upstream_url="https://www.cairographics.org/pycairo"
pkg_license=('LGPL' 'MPL')
pkg_deps=('python2' 'cairo')
pkg_source=("https://github.com/pygobject/pycairo/releases/download/v${pkg_version}/${_pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('405cce9d6d987df924200dc6efb0696e')

do_build() {
  
  python2 setup.py build
}

do_package() {
    
  python2 setup.py install --prefix=/usr --root=${CACHE_PATH} --optimize=1 --skip-build
}
