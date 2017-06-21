pkg_origin=cosmos

pkg_name=python2-pip
pkg_version=9.0.1
pkg_description="An easy_install replacement for installing pypi python2 packages"
pkg_upstream_url="http://www.pip-installer.org/"
pkg_license=('MIT')
pkg_deps=('python2' 'python2-setuptools')
pkg_source=("https://github.com/pypa/pip/archive/${pkg_version}.tar.gz")
pkg_shasum=('ae605ab1ccdcb7f9e219a400b4bc68b6')

do_package() {
  python2 setup.py build
  python2 setup.py install --prefix=/usr --root=${CACHE_PATH}

  mv ${CACHE_PATH}/usr/bin/pip ${CACHE_PATH}/usr/bin/pip2

  install -D -m644 LICENSE.txt ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
}
