pkg_origin=cosmos

pkg_name=gloox
pkg_version=1.0.20
pkg_description="C++ libraries for development of Jabber client/component/server"
pkg_upstream_url="http://camaya.net/gloox"
pkg_license=("GPL")
pkg_deps=('libidn' 'gnutls')
pkg_source=("http://camaya.net/download/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('2d7394e908f6637a96d0535c18b942e1')

do_build() {

  ./configure --prefix=/usr --without-examples
  make
}

do_package() {

  make DESTDIR=${pkg_prefix} install
}
