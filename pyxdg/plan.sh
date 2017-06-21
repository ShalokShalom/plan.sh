pkg_origin=cosmos

pkg_name=pyxdg
pkg_version=0.25
pkg_description="Python library to access freedesktop.org standards."
pkg_upstream_url="https://freedesktop.org/Software/pyxdg"
pkg_license=("LGPL")
pkg_deps=('python2')
pkg_source=("https://www.freedesktop.org/~takluyver/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('bedcdb3a0ed85986d40044c87f23477c')

do_package() {
  
  python setup.py install --prefix=/usr --root=${CACHE_PATH} 
}
