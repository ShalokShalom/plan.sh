pkg_origin=cosmos

pkg_name=python3-wrapt
pkg_version=1.10.10
pkg_description="Python module for decorators, wrappers and monkey patching."
pkg_upstream_url="https://github.com/GrahamDumpleton/wrapt"
pkg_license=('LGPL')
pkg_deps=('python3')
pkg_source=("https://github.com/GrahamDumpleton/wrapt/archive/${pkg_version}.tar.gz")
pkg_shasum=('94d8c04fb3a0ced0ecb6b8f003d1b253')


do_build() {
  
  python3 setup.py build
}

do_package() {

  python3 setup.py install --optimize=1 --skip-build --prefix=/usr --root=${CACHE_PATH}
  install -Dm644 LICENSE ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
}
