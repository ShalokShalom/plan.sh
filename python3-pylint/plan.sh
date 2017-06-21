pkg_origin=cosmos

pkg_name=python3-pylint
pkg_version=1.6.5
pkg_description="Tool that checks for errors in Python code and tries to enforce a coding standard"
pkg_upstream_url="http://pylint.org"
pkg_license=('GPL')
pkg_deps=('python3' 'python3-astroid')
pkg_build_deps=('python3-setuptools')
pkg_source=("https://github.com/PyCQA/pylint/archive/pylint-${pkg_version}.tar.gz")
pkg_shasum=('7fb54520b74d48ba6d1dc30820b64231')

do_build() {
    
    python3 setup.py build
}

do_package() {
    python3 setup.py install --prefix=/usr --root=${CACHE_PATH} --skip-build --optimize=1
    
    install -d ${CACHE_PATH}/usr/share/man/man1
    install -m644 man/* ${CACHE_PATH}/usr/share/man/man1
}
