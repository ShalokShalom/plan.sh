pkg_origin=cosmos

pkg_name=pysmbc
pkg_version=1.0.15.7
pkg_description="Python libsmbclient bindings"
pkg_upstream_url="https://github.com/hamano/pysmbc"
pkg_license=('GPL')
pkg_deps=('python3' 'samba')
pkg_source=("https://pypi.io/packages/source/p/${pkg_name}/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('f5538684792793fb53e1a1c9fdc6695d')

do_build(){
  
  python3 setup.py build
}

do_package() {
  
  python3 setup.py install --root=${CACHE_PATH} --optimize=1
}
