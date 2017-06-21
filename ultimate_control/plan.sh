pkg_origin=

pkg_name=ultimate_control
pkg_version=1.2
pkg_description="Ultimate Control is a set of software tools that allow you to take control of your computer wirelessly."
pkg_upstream_url="http://www.negusoft.com/index.php/ultimate-control"
pkg_license=('custom')
pkg_deps=('java-runtime')
pkg_source=("http://www.negusoft.com/downloads/${pkg_name}_v${pkg_version}_linux_64bit.tar.gz")
pkg_shasum=('0ad5bdbea3053ce419fd3b941262917b')

do_package() {
  cd ${CACHE_PATH}
  mkdir -p ${pkg_prefix}/usr/lib/ucontrol
  mkdir -p ${pkg_prefix}/usr/bin
  cp -f -r lib/ucontrol.jar ${pkg_prefix}/usr/lib/ucontrol/ucontrol.jar
  cp -f -r lib/icon.png ${pkg_prefix}/usr/lib/ucontrol/icon.png
  cp -f -r bin/ucontrol ${pkg_prefix}/usr/bin/ucontrol
  chmod 744 ${pkg_prefix}/usr/lib/ucontrol/*
  install -vDm644 "Ultimate Control.desktop" ${pkg_prefix}/usr/share/applications/${pkg_name}.desktop
}
