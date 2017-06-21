pkg_origin=cosmos

pkg_name=python3-idna
pkg_version=2.5
pkg_description="Support for the Internationalised Domain Names in Applications (IDNA) protocol as specified in RFC 5891. "
pkg_license=('LGPL')
pkg_upstream_url="https://github.com/kjd/idna/"
pkg_deps=('python3')
pkg_build_deps=('python3-setuptools')
pkg_source=("https://github.com/kjd/idna/archive/v${pkg_version}.tar.gz")
pkg_shasum=('f31cd2faf6954e13978f1d802a9dc9b6')

do_build() {
   
   python3 setup.py build
}
 
do_package() {
   
   python3 setup.py install --prefix=/usr --root=${CACHE_PATH} --optimize=1 --skip-build
   install -Dm644 LICENSE.rst ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
}
