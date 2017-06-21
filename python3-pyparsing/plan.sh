pkg_origin=cosmos

pkg_name=python3-pyparsing
pkg_version=2.2.0
pkg_description='General parsing module for Python'
pkg_upstream_url='http://pyparsing.wikispaces.com'
pkg_license=('MIT')
pkg_deps=('python3')
pkg_build_deps=('python3-setuptools')
pkg_source=("https://downloads.sourceforge.net/pyparsing/pyparsing-${pkg_version}.tar.gz")
pkg_shasum=('0214e42d63af850256962b6744c948d9')

do_package() {
  rm -rf build
  
  python3 setup.py install --prefix=/usr --root=${CACHE_PATH} --optimize=1
  install -Dm644 LICENSE ${CACHE_PATH}/usr/share/licenses/python3-pyparsing/LICENSE
}

