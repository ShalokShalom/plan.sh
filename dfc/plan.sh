pkg_origin=

pkg_name=dfc
pkg_version=3.1.0
pkg_description="Display file system space usage using graphs and colors"
pkg_upstream_url="https://projects.gw-computing.net/projects/dfc"
pkg_license=('BSD')
pkg_deps=('glibc')
pkg_build_deps=('cmake' 'gettext')
pkg_source=("https://projects.gw-computing.net/attachments/download/614/${pkg_name}-${pkg_version}.tar.gz")
install='dfc.install'
pkg_shasum=('419cec7a0e237b056f631c3dc44b9e77')

do_build() {
  cd ${pkg_name}-${pkg_version}

  cmake . -DPREFIX=/usr -DSYSCONFDIR=/etc -DCMAKE_BUILD_TYPE=RELEASE
  make
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  make DESTDIR=${pkg_prefix} install

  install -Dm644 LICENSE ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}

