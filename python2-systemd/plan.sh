pkg_origin=cosmos

pkg_name=python2-systemd
_pkg_name=python-systemd
pkg_version=234
pkg_description="Python module for native access to the systemd facilities."
pkg_license=('LGPLv2+')
pkg_upstream_url="https://github.com/systemd/python-systemd"
pkg_deps=('python2')
pkg_build_deps=('python2-sphinx' 'python2-lxml' 'systemd')
pkg_source=("https://github.com/systemd/python-systemd/archive/v${pkg_version}.tar.gz")
pkg_shasum=('752929b651d1c6b2a42d454f58b94974')

do_build() {
  cd ${_pkg_name}-${pkg_version}

  python2 setup.py build
  make
  #make sphinx-html
}

do_package() {
  cd ${_pkg_name}-${pkg_version}

  python2 setup.py install --root=${pkg_prefix}/
}
