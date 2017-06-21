pkg_origin=cosmos

pkg_name=mcpp
pkg_version=2.7.2
pkg_description="Matsui's CPP implementation precisely conformed to standards"
pkg_license=('custom')
pkg_upstream_url="http://mcpp.sourceforge.net"
pkg_deps=('glibc')
pkg_source=("https://downloads.sourceforge.net/mcpp/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('512de48c87ab023a69250edc7a0c7b05')

do_build() {
  
  ./configure --prefix=/usr --enable-mcpplib --disable-static
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install

  install -m755 -d ${pkg_prefix}/usr/share/licenses/${pkg_name}
  ln -sf ../doc/${pkg_name}/LICENSE ${pkg_prefix}/usr/share/licenses/${pkg_name}/
}
