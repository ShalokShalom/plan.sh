pkg_origin=cosmos

pkg_name=python3-logilab-common
pkg_version=1.4.0
pkg_description="Bunch of modules providing low level functionnalities shared among some python projects devel"
pkg_upstream_url="https://www.logilab.org/project/logilab-common"
pkg_license=('LGPL')
pkg_deps=('python3-six')
pkg_build_deps=('python3-setuptools')
pkg_source=("https://pypi.io/packages/source/l/logilab-common/logilab-common-${pkg_version}.tar.gz")
pkg_shasum=('8dda519f642494789a21513752b9edbe')

do_build() {

  python3 setup.py build
}

do_package() {
  python3 setup.py install --optimize=1 --skip-build --prefix=/usr --root=${CACHE_PATH}

  find ${CACHE_PATH} -type f -exec chmod +r {} \;
}
