pkg_origin=cosmos

pkg_name=python3-pip
pkg_version=9.0.1
pkg_description="An easy_install replacement for installing pypi python3 packages"
pkg_upstream_url="https://pip.pypa.io/"
pkg_license=('MIT')
pkg_deps=('python3' 'python3-setuptools')
pkg_source=("https://github.com/pypa/pip/archive/${pkg_version}.tar.gz")
pkg_shasum=('ae605ab1ccdcb7f9e219a400b4bc68b6')

do_package() {
  python3 setup.py build
  python3 setup.py install --prefix=/usr --root=${CACHE_PATH}
  
  sed -i "s|#!/usr/bin/env python$|#!/usr/bin/env python3|" \
    ${CACHE_PATH}/usr/lib/python3.6/site-packages/pip/__init__.py

  install -D -m644 LICENSE.txt ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
}
