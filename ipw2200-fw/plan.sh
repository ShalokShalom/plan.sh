pkg_origin=cosmos

pkg_name=ipw2200-fw
pkg_version=3.1
pkg_description="Firmware for the Intel PRO/Wireless 2200BG"
pkg_upstream_url='http://ipw2200.sourceforge.net/'
pkg_license=('custom')
pkg_source=("http://mirrors.slackware.com/slackware/slackware-current/source/n/$pkg_name/$pkg_name-$pkg_version.tar.xz")
pkg_shasum=('7066e4cf1d94c319c53dfb2603edb757')

do_package() {
  cd "${CACHE_PATH}/ipw2200-fw-${pkg_version}"
  # Install firmware
  for i in ipw*.fw; do
    install -D -m 644 $i "${pkg_prefix}/usr/lib/firmware/$i"
  done
  # Install license
  install -D -m 644 LICENSE.ipw2200-fw "${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE"
}
