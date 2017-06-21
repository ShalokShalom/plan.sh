pkg_origin=cosmos

pkg_name=python3-chardet
pkg_version=3.0.4
pkg_description="Character encoding auto-detection in Python. As smart as your browser."
pkg_license=('LGPL')
pkg_upstream_url="http://chardet.readthedocs.org/"
pkg_deps=('python3')
pkg_build_deps=('python3-setuptools')
pkg_source=("https://github.com/chardet/chardet/archive/${pkg_version}.tar.gz")
pkg_shasum=('f37b246e5136c96828bb92f86d2354d1')

do_build() {
   
   python3 setup.py build
}
 
do_package() {
   
   python3 setup.py install --prefix=/usr --root=${CACHE_PATH} --optimize=1 --skip-build
   install -Dm644 LICENSE ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
}
