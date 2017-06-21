pkg_origin=cosmos

pkg_name=ccnet
pkg_version=6.0.6
pkg_description="Ccnet is a framework for writing networked applications in C."
pkg_upstream_url="https://github.com/haiwen/ccnet/"
pkg_license=('GPLv3')
pkg_deps=('libsearpc' 'libzdb' 'libevent')
pkg_build_deps=('vala' 'python2')
pkg_source=("https://github.com/haiwen/ccnet/archive/v${pkg_version}.tar.gz")
pkg_shasum=('868b55b8731bdc2c0f2e20b97bd95585')

#prepare() {
  #export PREFIX=${pkg_prefix}/usr
  #export PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig
#}
do_build() {

  ./autogen.sh
  ./configure --prefix=/usr
  make
}

do_package() {

  make DESTDIR=${pkg_prefix} install
}
