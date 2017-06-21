pkg_origin=

pkg_name=seafile
pkg_version=6.0.6
pkg_description="Open source cloud storage with advanced features on privacy protection and teamwork."
pkg_upstream_url="https://github.com/haiwen/seafile/"
pkg_license=('GPLv3')
pkg_deps=('ccnet' 'fuse' 'python2' 'libevent')
pkg_build_deps=('intltool' 'vala')
pkg_source=("https://github.com/haiwen/seafile/archive/v${pkg_version}.tar.gz")
pkg_shasum=('8958fc32def4d6269f18d1f96562be9f')

do_build() {
  cd ${pkg_name}-${pkg_version}

  ./autogen.sh
  ./configure --prefix=/usr
  make
}

do_package() {
  cd ${pkg_name}-${pkg_version}

  make DESTDIR=${pkg_prefix} install
}
