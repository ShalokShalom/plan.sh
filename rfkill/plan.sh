pkg_origin=cosmos

pkg_name=rfkill
pkg_version=0.5
pkg_description="Tool to query and set the rfkill state of wireless devices"
pkg_upstream_url="http://linuxwireless.org/en/users/Documentation/rfkill"
pkg_license=('custom')
pkg_deps=('glibc' 'filesystem')
pkg_source=("https://www.kernel.org/pub/software/network/rfkill/${pkg_name}-${pkg_version}.tar.xz"
        '60-rfkill.rules'
        'service.block'
        'service.unblock')
backup=(etc/conf.d/rfkill)
pkg_shasum=('ce834c00c049cd86a04ab115c92ef548'
         '63f9bf9264911242e430867a41e8918c'
         'a5835e0d5686ad1a12644edc3333d886'
         '3a87d0d77656f005fbd9c3b003dadc90')

do_build() {
  cd ${pkg_name}-${pkg_version}
  
  make
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  make DESTDIR=${pkg_prefix} install

  install -Dm644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE

  install -Dm644 ${CACHE_PATH}/60-rfkill.rules ${pkg_prefix}/usr/lib/udev/rules.d/60-rfkill.rules
  install -Dm644 ${CACHE_PATH}/service.block ${pkg_prefix}/usr/lib/systemd/system/rfkill-block@.service
  install -Dm644 ${CACHE_PATH}/service.unblock ${pkg_prefix}/usr/lib/systemd/system/rfkill-unblock@.service
}

