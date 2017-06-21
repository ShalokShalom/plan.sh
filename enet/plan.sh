pkg_origin=

pkg_name=enet
pkg_version=1.3.13
pkg_description='Thin, simple and robust network communication layer on top of UDP.'
pkg_upstream_url='http://enet.bespin.org/'
pkg_license=('custom')
pkg_deps=('glibc')
pkg_source=("http://enet.bespin.org/download/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('b83b9a7791417b6b6f5c68231f6e218b')

do_build() {
  cd ${pkg_name}-${pkg_version}
  
  ./configure --prefix=/usr
  make
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  make DESTDIR=${pkg_prefix} install
  
  install -Dm644 LICENSE ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
