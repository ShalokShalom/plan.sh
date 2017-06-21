pkg_origin=cosmos

pkg_name=python3-appdirs
pkg_version=1.4.3
pkg_description="Small Python module for determining appropriate platform-specific dirs."
pkg_license=('MIT')
pkg_upstream_url="http://pypi.python.org/pypi/appdirs"
pkg_deps=('python3')
pkg_build_deps=('python3-setuptools')
pkg_source=("https://github.com/ActiveState/appdirs/archive/${pkg_version}.tar.gz")
pkg_shasum=('b0bd73c5dac1bee973e60adcbdcbb5ed')

do_build() {

   python3 setup.py build
}
 
do_check() {

   python3 setup.py test
}
 
do_package() {
   python3 setup.py install --prefix=/usr --root=${CACHE_PATH} --optimize=1 --skip-build
   
   install -Dm644 LICENSE.txt ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE.txt
}
 

