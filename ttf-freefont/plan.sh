pkg_origin=cosmos

pkg_name=ttf-freefont
pkg_version=20120503
pkg_description="A set of free high-quality TrueType fonts covering the Unicode character set"
pkg_upstream_url="https://www.nongnu.org/freefont/"
pkg_license=('GPL')
pkg_deps=('fontconfig' 'xorg-font-utils')
install=${pkg_name}.install
pkg_source=("https://ftp.gnu.org/gnu/freefont/freefont-ttf-${pkg_version}.zip")
pkg_shasum=('879b76d2e3c8003d567b555743f39154')

do_package() {
  
  install -d ${CACHE_PATH}/usr/share/fonts/TTF
  install -m0644 *.ttf ${CACHE_PATH}/usr/share/fonts/TTF/
}
