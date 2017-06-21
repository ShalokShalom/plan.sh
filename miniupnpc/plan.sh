pkg_origin=cosmos

pkg_name=miniupnpc
pkg_version=2.0
pkg_description="Small UPnP client library/tool to access Internet Gateway Devices"
pkg_upstream_url="https://miniupnp.tuxfamily.org/"
pkg_license=('BSD')
pkg_deps=('sh')
pkg_source=("https://miniupnp.tuxfamily.org/files/download.php?file=${pkg_name}-${pkg_version}.tar.gz"
        'CVE-2017-8798.diff')
pkg_shasum=('2acc4ec912c15447a40cf14ae50df7b9'
         '0e359ab89d9abac2911e2ce904d39a18')

do_build() {
  patch -p1 -i ${CACHE_PATH}/CVE-2017-8798.diff
  
  make
}

do_package() {
  make PREFIX=${pkg_prefix}/ install
  
  install -Dm644 man3/miniupnpc.3 ${pkg_prefix}/usr/share/man/man3/miniupnpc.3
  install -Dm644 LICENSE ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
