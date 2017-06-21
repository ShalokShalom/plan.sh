pkg_origin=cosmos

pkg_name=ttf-khmer
pkg_version=5.0
pkg_description="TTFont collection for Khmer (Cambodia)"
pkg_license=('LGPL')
pkg_upstream_url='http://www.khmeros.info/drupal612/en/taxonomy/term/53'
pkg_deps=('xorg-fonts-encodings' 'xorg-fonts-alias' 'xorg-font-utils' 'fontconfig')
install=ttf.install
pkg_source=("http://downloads.sourceforge.net/sourceforge/khmer/All_KhmerOS_${pkg_version}.zip")
pkg_shasum=('dc1ddeb526ccbc06603da880d1e89e7b')

do_package() {
  install -dm755 ${CACHE_PATH}/usr/share/fonts/TTF
  install -m644 *.ttf ${CACHE_PATH}/usr/share/fonts/TTF/
}
