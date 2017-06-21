pkg_origin=cosmos
pkg_name=pyalpm
pkg_version=0.8.1
pkg_description="Libalpm bindings for Python 3"
pkg_upstream_url="https://projects.archlinux.org/pyalpm.git"
pkg_license=('GPL')
pkg_deps=('python3' 'pacman')
pkg_source=("https://git.archlinux.org/pyalpm.git/snapshot/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('32d0b528af430e049cbb278d61ebabc8')

do_build() {

  python3 setup.py build
}

do_package() {

  python3 setup.py install --root=${CACHE_PATH}
}
