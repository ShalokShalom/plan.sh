pkg_origin=cosmos

pkg_name=python2-docutils
pkgbase=docutils
pkg_version=0.13.1
pkg_description="Set of tools for processing plaintext docs into formats such as HTML, XML, or LaTeX"
pkg_upstream_url="http://docutils.sourceforge.net"
pkg_license=('custom')
pkg_deps=('python2')
pkg_source=("http://downloads.sourceforge.net/docutils/docutils-$pkg_version.tar.gz")
pkg_shasum=('ea4a893c633c788be9b8078b6b305d53')

do_build() {
  
  python2 setup.py build
}

do_package() {
  python2 setup.py install --root=${CACHE_PATH} --optimize=1

  for _f in ${CACHE_PATH}/usr/bin/*.py; do
      ln -s $(basename $_f) ${CACHE_PATH}/usr/bin/$(basename $_f .py)
  done

  install -D -m644 COPYING.txt ${CACHE_PATH}/usr/share/licenses/${pkg_name}/COPYING.txt
  install -D -m644 licenses/python* ${CACHE_PATH}/usr/share/licenses/${pkg_name}/
}
