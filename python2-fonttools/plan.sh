pkg_origin=cosmos

pkg_name=python2-fonttools
pkg_version=3.13.1
pkg_description="Converts OpenType and TrueType fonts to and from XML"
pkg_upstream_url="https://github.com/behdad/fonttools/"
pkg_license=('BSD')
pkg_deps=('python2-numpy')
pkg_build_deps=('python2-setuptools')
pkg_source=("https://github.com/behdad/fonttools/archive/${pkg_version}.tar.gz")
pkg_shasum=('67549efaff55b2510b3462566f2da5cb')

do_build() {

  python2 setup.py build
}

do_package() {

  python2 setup.py install --root=${CACHE_PATH} --optimize=1

  install -D -m755 LICENSE ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
  chmod oga+r ${CACHE_PATH}/usr/share/man/man1/ttx.1
}

