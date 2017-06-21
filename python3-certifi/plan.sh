pkg_origin=cosmos

pkg_name=python3-certifi
_pkg_name=python-certifi
pkg_version=2017.04.17
pkg_description="Carefully curated collection of Root Certificates for validating the trustworthiness of SSL certificates."
pkg_license=('MPL2.0')
pkg_upstream_url="https://certifi.io/en/latest/"
pkg_deps=('python3')
pkg_build_deps=('python3-setuptools')
pkg_source=("https://github.com/certifi/python-certifi/archive/${pkg_version}.tar.gz")
pkg_shasum=('34d86e84752e1870704228ef20868ba5')

do_build() {
   
   python3 setup.py build
}
 
do_package() {
   
   python3 setup.py install --prefix=/usr --root=${CACHE_PATH} --optimize=1 --skip-build
   install -Dm644 LICENSE ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
}
