pkg_origin=cosmos

_pkg_name=ubuntu-font-family
pkg_name=ttf-ubuntu-font
pkg_version=0.83
pkg_description="The default TTF font family used by Ubuntu."
pkg_license=('custom:ubuntu-font-licence-1.0')
pkg_upstream_url="https://font.ubuntu.com/"
pkg_deps=('fontconfig' 'xorg-font-utils')
pkg_source=("http://font.ubuntu.com/download/${_pkg_name}-${pkg_version}.zip")
install=${pkg_name}.install
pkg_shasum=('a24b8136b8f3bb93f166baf97d9328de')

do_package() {

  install -dm755 ${CACHE_PATH}/usr/share/fonts/TTF
  install -m0644 Ubuntu-{L,R,B,C,M}*.ttf ${CACHE_PATH}/usr/share/fonts/TTF/
  install -m0644 UbuntuMono-*.ttf ${CACHE_PATH}/usr/share/fonts/TTF/
  install -Dm0644 LICENCE.txt ${CACHE_PATH}/usr/share/${pkg_name}/LICENSE
}
