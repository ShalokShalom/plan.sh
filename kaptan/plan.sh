pkg_origin=

pkg_name=kaptan
pkg_version=5.3.9
pkg_description="KaOS Desktop Configuration wizard, forked from Pisi Linux"
pkg_upstream_url="https://github.com/KaOSx/kaptan"
pkg_license=('GPL')
pkg_deps=('pyqt5-python3' 'plasma-workspace' 'sip3')
pkg_build_deps=('python3-setuptools')
pkg_source=("git://github.com/KaOSx/kaptan")
pkg_shasum=('SKIP')

do_package() {
  cd ${pkg_name}

  python3 setup.py install --root=${pkg_prefix} --optimize=1
}
