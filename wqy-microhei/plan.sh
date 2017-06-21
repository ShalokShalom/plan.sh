pkg_origin=cosmos

pkg_name=wqy-microhei
pkg_version=0.2.0_beta
_pkg_version=0.2.0-beta
pkg_description="A Sans-Serif style high quality CJK outline font."
pkg_upstream_url="http://wenq.org"
pkg_license=('GPL3' 'APACHE' 'custom:"font embedding exception"')
install=wqy-microhei.install
pkg_deps=('fontconfig' 'xorg-font-utils')
pkg_source=("https://downloads.sourceforge.net/project/wqy/${pkg_name}/${_pkg_version}/${pkg_name}-${_pkg_version}.tar.gz"
        '44-wqy-microhei.conf')
pkg_shasum=('a124c5c6606f4f3b733d3477380e9d2f'
         '2614129902fda4e45aa7f0f7b635cc4f')
do_build() {
  tail README.txt --lines=16|head --lines=-3>| FONTEXCEPTION
}

do_package() {
  install -d ${CACHE_PATH}/etc/fonts/conf.d/
  install -Dm644 ${CACHE_PATH}/44-wqy-microhei.conf ${CACHE_PATH}/etc/fonts/conf.avail/44-wqy-microhei.conf
  install -Dm644 ${CACHE_PATH}/${pkg_name}/wqy-microhei.ttc ${CACHE_PATH}/usr/share/fonts/wenquanyi/${pkg_name}/wqy-microhei.ttc
  install -Dm644 ${CACHE_PATH}/${pkg_name}/FONTEXCEPTION ${CACHE_PATH}/usr/share/licenses/${pkg_name}/FONTEXCEPTION
  ln -s ../conf.avail/44-wqy-microhei.conf .
}
