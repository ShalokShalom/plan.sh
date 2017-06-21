pkg_origin=cosmos

pkg_name=python2-packaging
pkg_version=16.8
pkg_description="Core utilities for Python3 packages"
pkg_license=('Apache')
pkg_upstream_url="https://github.com/pypa/packaging"
pkg_deps=('python2-six' 'python2-pyparsing')
pkg_source=("https://github.com/pypa/packaging/archive/${pkg_version}.tar.gz")
pkg_shasum=('02c9a248368c7b9d3236cac349a67825')

do_build() {
   
   python2 setup.py build
}
 
do_package() {
   
   python2 setup.py install --prefix=/usr --root=${CACHE_PATH} 
   #rm ${CACHE_PATH}/usr/bin/easy_install
}
 

