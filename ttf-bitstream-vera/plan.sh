pkg_origin=cosmos

pkg_name=ttf-bitstream-vera
pkg_version=1.10
pkg_description="Bitstream vera fonts"
pkg_license=('custom')
pkg_upstream_url="http://www.gnome.org/fonts"
pkg_deps=('fontconfig' 'xorg-fonts-encodings' 'xorg-font-utils')
install=vera.install
pkg_source=("http://ftp.gnome.org/pub/GNOME/sources/${pkg_name}/1.10/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=(bb22bd5b4675f5dbe17c6963d8c00ed6)

do_package() {
  install -d "${CACHE_PATH}/usr/share/fonts/TTF"
  install -m0644 *.ttf "${CACHE_PATH}/usr/share/fonts/TTF/"
  install -Dm0644 COPYRIGHT.TXT "${CACHE_PATH}/usr/share/licenses/ttf-bitstream-vera/LICENSE"
}
