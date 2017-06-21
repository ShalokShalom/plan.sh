pkg_origin=

pkg_name=init-live
pkg_version=2017.03
pkg_description="Live-session systemd startup scripts"
pkg_upstream_url="http://www.kaosx.us"
pkg_license=('GPL2')
pkg_deps=()
install=init-live.install
pkg_source=('live' 'locale_setup.sh' 'live.service')
pkg_shasum=('ab2bd8f06d4887adb61e0c62b1d07661'
         'c519d89a1ca9f5080153367138c25baa'
         '571358cfe8eac5546e90c1341100e903')

do_package() {
  cd ${CACHE_PATH}
  # setup /etc
  mkdir ${pkg_prefix}/etc
  install -m755 -t ${pkg_prefix}/etc live
  install -m755 -t ${pkg_prefix}/etc locale_setup.sh	
  
  install -Dm644 live.service ${pkg_prefix}/usr/lib/systemd/system/live.service
}
