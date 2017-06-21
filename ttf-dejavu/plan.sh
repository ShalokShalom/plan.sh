pkg_origin=cosmos

pkg_name=ttf-dejavu
pkg_version=2.37
pkg_description="Font family based on the Bitstream Vera Fonts with a wider range of characters"
pkg_upstream_url="http://dejavu.sourceforge.net/"
pkg_license=('custom')
pkg_deps=('fontconfig' 'xorg-fonts-encodings')
install=ttf-dejavu.install
pkg_source=("http://downloads.sourceforge.net/project/dejavu/dejavu/${pkg_version}/dejavu-fonts-ttf-${pkg_version}.tar.bz2")
pkg_shasum=('d0efec10b9f110a32e9b8f796e21782c')

do_package() {
  install -dm755 ${CACHE_PATH}/etc/fonts/conf.avail
  install -dm755 ${CACHE_PATH}/usr/share/fonts/TTF

  install -m644 ttf/*.ttf ${CACHE_PATH}/usr/share/fonts/TTF/
  install -m644 fontconfig/*.conf ${CACHE_PATH}/etc/fonts/conf.avail/

  install -Dm644 LICENSE ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
}
