pkg_origin=cosmos

pkg_name=ipw2100-fw
pkg_version=1.3
pkg_description="Intel Centrino Drivers firmware for IPW2100"
pkg_upstream_url="http://ipw2100.sourceforge.net/"
pkg_license=('custom')
pkg_source=("http://mirrors.slackware.com/slackware/slackware-current/source/n/ipw2100-fw/$pkg_name-$pkg_version.tar.bz2")
pkg_shasum=('12ef9d7787ffff93fcec49dd778e7706')

do_package() {
  cd "${CACHE_PATH}"

  # Install firmware
  for i in *.fw
  do
    install -D -m 644 $i "${pkg_prefix}/usr/lib/firmware/$i"
  done 

  install -D -m 644 LICENSE "${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE"
}
