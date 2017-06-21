pkg_origin=cosmos

pkgbase=distribute
pkg_name=('python2-distribute' 'python3-distribute')
pkg_version=0.6.49
pkg_description="Easily download, build, install, upgrade, and uninstall Python packages"
pkg_license=('PSF')
pkg_upstream_url="http://packages.python.org/distribute"
pkg_build_deps=('python2' 'python3')
pkg_source=("http://pypi.python.org/packages/source/d/distribute/${pkgbase}-${pkg_version}.tar.gz")
pkg_shasum=('89e68df89faf1966bcbd99a0033fbf8e')

do_build() {
  msg2 "Starting the Python 2.x build"
  rm -rf "python2-${pkgbase}"
  cp -r "${pkgbase}-${pkg_version}" "python2-${pkgbase}"

  python2 setup.py build

  msg2 "Starting the Python 3.x build"
  rm -rf "python3-${pkgbase}"
  cp -r "${pkgbase}-${pkg_version}" "python3-${pkgbase}"

  python3 setup.py build
}

package_python2-distribute() {
pkg_deps=('python2')

  python2 setup.py install --prefix=/usr --root="${CACHE_PATH}"
  rm "${CACHE_PATH}/usr/bin/easy_install"
}

package_python3-distribute() {
pkg_deps=('python3')

  python3 setup.py install --prefix=/usr --root="${CACHE_PATH}"
  rm "${CACHE_PATH}/usr/bin/easy_install"
}

