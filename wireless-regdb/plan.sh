pkg_origin=cosmos

pkg_name=wireless-regdb
pkg_version=2017.03.07
pkg_description="Central Regulatory Domain Database"
pkg_upstream_url="https://wireless.kernel.org/en/developers/Regulatory/CRDA"
backup=(etc/conf.d/wireless-regdom)
pkg_license=('custom')
pkg_deps=('sh')
pkg_build_deps=('crda')
install=wireless-regdb.install
pkg_source=("https://www.kernel.org/pub/software/network/${pkg_name}/${pkg_name}-${pkg_version}.tar.xz"
        'crda.conf.d')
pkg_shasum=('52816bd259b1b28508a17e2592a5669c'
         '2374dcf1c6530332f375e5362b80169b')

do_package() {
  cd ${pkg_name}-${pkg_version}
  make DESTDIR=${pkg_prefix} install
  
  install -D -m644 ${CACHE_PATH}/${pkg_name}-${pkg_version}/sforshee.key.pub.pem ${pkg_prefix}/usr/lib/crda/pubkeys/sforshee.key.pub.pem
  install -D -m644 ${CACHE_PATH}/${pkg_name}-${pkg_version}/regulatory.bin.5 ${pkg_prefix}/usr/share/man/man5/regulatory.bin.5
  
  install -D -m644 ${CACHE_PATH}/crda.conf.d ${pkg_prefix}/etc/conf.d/wireless-regdom
  for dom in $(grep ^country ${CACHE_PATH}/${pkg_name}-${pkg_version}/db.txt | cut -d' ' -f2 | sed 's|:||g'); do
    echo "#WIRELESS_REGDOM=\"${dom}\"" >> ${pkg_prefix}/etc/conf.d/wireless-regdom.tmp
  done
  sort -u ${pkg_prefix}/etc/conf.d/wireless-regdom.tmp >> ${pkg_prefix}/etc/conf.d/wireless-regdom
  rm -f ${pkg_prefix}/etc/conf.d/wireless-regdom.tmp

  install -D -m644 ${CACHE_PATH}/${pkg_name}-${pkg_version}/LICENSE ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
