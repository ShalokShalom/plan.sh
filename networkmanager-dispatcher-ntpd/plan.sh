pkg_origin=cosmos

pkg_name=networkmanager-dispatcher-ntpd
pkg_version=1.0
pkg_description="Dispatcher script for ntpd."
pkg_license=('BSD')
pkg_upstream_url="http://www.gnome.org/projects/NetworkManager"
pkg_deps=('networkmanager' 'ntp')
pkg_source=("10-ntpd")
pkg_shasum=('2eb9dd950cd7b00c4c523de6a1b46517')

do_package() {
  install -Dm700 ${CACHE_PATH}/10-ntpd ${pkg_prefix}/etc/NetworkManager/dispatcher.d/10-ntpd
}

