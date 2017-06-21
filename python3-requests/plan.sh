pkg_origin=cosmos

pkg_name=python3-requests
pkg_version=2.18.1
pkg_description="Requests is the only Non-GMO HTTP library for Python, safe for human consumption."
pkg_license=('Apache')
pkg_upstream_url="http://docs.python-requests.org/en/master/"
pkg_deps=('python3-urllib3' 'python3-chardet' 'python3-certifi' 'python3-idna')
pkg_build_deps=('python3-setuptools')
pkg_source=("https://github.com/kennethreitz/requests/archive/v${pkg_version}.tar.gz")
pkg_shasum=('a3d6f123e328ab97131f8232a17eebdc')

do_build() {
   
   python3 setup.py build
}
 
do_package() {
   
   python3 setup.py install --prefix=/usr --root=${CACHE_PATH} --optimize=1 --skip-build
   install -Dm644 LICENSE ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
}
