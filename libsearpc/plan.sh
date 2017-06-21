pkg_origin=cosmos

pkg_name=libsearpc
pkg_version=3.0.7
pkg_description="A simple and easy-to-use C language RPC framework"
pkg_upstream_url="https://github.com/haiwen/libsearpc/"
pkg_license=('GPLv3')
pkg_deps=('glib2' 'jansson' 'libtool')
pkg_build_deps=('python2-simplejson')
pkg_source=("https://github.com/haiwen/libsearpc/archive/v${pkg_version}.tar.gz")
pkg_shasum=('1d20e93e0fb39f98c907e633d9f1b11b')

do_build() {

  ./autogen.sh
  ./configure --prefix=/usr
  make
}

do_package() {

  make DESTDIR=${pkg_prefix} install
}
