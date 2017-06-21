pkg_origin=cosmos

pkg_name=rp-pppoe
pkg_version=3.12
pkg_description="Roaring Penguin's Point-to-Point Protocol over Ethernet client"
pkg_upstream_url="http://www.roaringpenguin.com/pppoe/"
pkg_license=('GPL')
pkg_deps=('ppp>=2.4.7' 'sh')
backup=(etc/ppp/{pppoe.conf,firewall-standalone,firewall-masq,pppoe-server-options})
pkg_source=("http://www.roaringpenguin.com/files/download/rp-pppoe-${pkg_version}.tar.gz"
        'adsl.service'
        'kmode.patch'
        'fix-linux-vs-glibc-headers-compile-error-mess.patch')
pkg_shasum=('216eb52b69062b92a64ee37fd71f4b66'
         'ae14bb45cdd6aad31395a301f96ddd82'
         '7f1bea3193b381bfaeb6cab1e0478300'
         '2941e74b4e8dc98d252906f8bff2d18e')

do_build() {
  cd ${pkg_name}-${pkg_version}/src
  patch -p2 -i ${CACHE_PATH}/kmode.patch
  #fix from FW for glibc 2.25
  patch -p2 -i ${CACHE_PATH}/fix-linux-vs-glibc-headers-compile-error-mess.patch
  
  ./configure --prefix=/usr \
              --enable-plugin
  make
}

do_package() {
  cd ${pkg_name}-${pkg_version}/src
  make PLUGIN_DIR="/usr/lib/rp-pppoe" DESTDIR=${pkg_prefix} install
  
  install -Dm644 ${CACHE_PATH}/adsl.service ${pkg_prefix}/usr/lib/systemd/system/adsl.service
}
