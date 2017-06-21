pkg_origin=

pkg_name=transifex-client
pkg_version=0.12.4
pkg_description="Command line tool that enables you to easily manage your translations within a project without the need of an elaborate UI system."
pkg_upstream_url="https://github.com/transifex/transifex-client"
pkg_license=('GPL2')
pkg_deps=('python3-urllib3' 'python3-six')
pkg_build_deps=('python3-setuptools')
pkg_source=("https://github.com/transifex/transifex-client/archive/${pkg_version}.tar.gz")
pkg_shasum=('521bf5615e22adc7741edb35ef4acd3a')

do_build() {
  cd ${pkg_name}-${pkg_version}

  python3 setup.py build
}

do_package() {
  cd ${pkg_name}-${pkg_version}

  python3 setup.py install --root=${pkg_prefix} --optimize=1
}
