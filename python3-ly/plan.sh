pkg_origin=cosmos

pkg_name=python3-ly
_pkg_name=python-ly
pkg_version=0.9.5
pkg_description="A Python package and commandline tool to manipulate LilyPond files"
pkg_upstream_url="https://pypi.python.org/pypi/python-ly/"
pkg_license=('LGPL')
pkg_deps=('python3')
pkg_build_deps=('python3')
pkg_source=("https://github.com/wbsoft/python-ly/archive/v${pkg_version}.tar.gz")
pkg_shasum=('e7547dc3dcc75e381f97dad67a17ce12')

do_package() {

    python3 setup.py install --root=${CACHE_PATH}
}
