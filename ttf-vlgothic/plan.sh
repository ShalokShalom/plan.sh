pkg_origin=cosmos

pkg_name=ttf-vlgothic
pkg_version=20120905
pkg_description="Japanese TrueType fonts from Vine Linux"
pkg_upstream_url="http://vlgothic.dicey.org/"
pkg_license=('custom')
pkg_deps=('fontconfig' 'xorg-font-utils')
install=$pkg_name.install
pkg_source=("http://dl.sourceforge.jp/vlgothic/56782/VLGothic-${pkg_version}.tar.bz2")
pkg_shasum=('f0739d485720749e2067aac5743c4834724a36ef9e34a5e84cc19dd3562d67ea')

do_package() {
	
  install -d "${CACHE_PATH}/usr/share/fonts/TTF"
  install -m0644 *.ttf "${CACHE_PATH}/usr/share/fonts/TTF"
	
  install -Dm0644 "LICENSE_E.mplus" \
    "${CACHE_PATH}/usr/share/licenses/${pkg_name}/COPYING_MPLUS.txt"
  install -Dm644 README.sazanami \
    "${CACHE_PATH}/usr/share/licenses/${pkg_name}/COPYING_SAZANAMI.txt"
  install -Dm0644 LICENSE.en \
    "${CACHE_PATH}/usr/share/licenses/${pkg_name}/COPYING_VLGOTHIC.txt"
}
