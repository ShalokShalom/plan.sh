pkg_origin=cosmos
 
pkg_name=whois
pkg_version=5.2.16
pkg_description="Intelligent WHOIS client"
pkg_upstream_url="https://github.com/rfc1036/whois"
pkg_license=('GPLv2')
pkg_deps=('libidn')
pkg_build_deps=('perl')
backup=('etc/whois.conf')
pkg_source=("http://ftp.debian.org/debian/pool/main/w/whois/${pkg_name}_${pkg_version}.tar.xz")
pkg_shasum=('1cc5d3820994806373b8b6ad9afda868')

do_build() {

  make 
}

do_package() {
  make prefix=/usr BASEDIR=${CACHE_PATH} install-whois
  make prefix=/usr BASEDIR=${CACHE_PATH} install-pos
  
  install -D -m644 COPYING  ${CACHE_PATH}/usr/share/licenses/${pkg_name}/COPYING
}
