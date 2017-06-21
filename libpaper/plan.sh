pkg_origin=cosmos

pkg_name=libpaper
pkg_version=1.1.24
_pkg_version=1.1.24+nmu5
pkg_description='Library for handling paper characteristics'
pkg_upstream_url='https://packages.debian.org/unstable/source/libpaper'
pkg_license=('GPL')
pkg_deps=('sh' 'run-parts')
pkg_source=("http://ftp.de.debian.org/debian/pool/main/libp/libpaper/${pkg_name}_${_pkg_version}.tar.gz")
pkg_shasum=('38bc55688c0fc5544edaa5a951a45fbd')

do_build() {

  autoreconf -vi
  ./configure --prefix=/usr --sysconfdir=/etc 
  make
}

do_package() {
  make -C ${pkg_name}-${_pkg_version} DESTDIR=${pkg_prefix} install
}
