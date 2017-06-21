pkg_origin=cosmos

pkg_name=python3-urllib3
pkg_version=1.21.1
pkg_description="Python HTTP library with thread-safe connection pooling, file post support, sanity friendly, and more."
pkg_license=('MIT')
pkg_upstream_url="https://urllib3.readthedocs.io/en/latest/"
pkg_deps=('python3')
pkg_build_deps=('python3-setuptools')
pkg_source=("https://github.com/shazow/urllib3/archive/${pkg_version}.tar.gz")
pkg_shasum=('b0a2c692ea273dc120b209a027b0df3c')

do_build() {
   
   python3 setup.py build
}
 
do_package() {
   
   python3 setup.py install --prefix=/usr --root=${CACHE_PATH} --optimize=1 --skip-build
   install -Dm644 LICENSE.txt ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE.txt
}
