pkg_origin=cosmos

pkg_name=urw-core35-fonts
pkg_version=20160712
_commit=79bcdfb
pkg_description="Ghostscript standard Type1 fonts from URW+"
pkg_upstream_url="http://git.ghostscript.com/?p=urw-core35-fonts.git;a=summary"
pkg_license=('AGPL3')
pkg_deps=('xorg-font-utils' 'fontconfig')
install=fonts.install
pkg_source=("http://git.ghostscript.com/?p=urw-core35-fonts.git;a=snapshot;h=79bcdfb34fbce12b592cce389fa7a19da6b5b018;sf=tgz")
pkg_shasum=('559f1a14899c32401ac044e90648c5d5')

do_package() {
  
  install -d ${CACHE_PATH}/usr/share/fonts/OTF
  install -m644 *.otf ${CACHE_PATH}/usr/share/fonts/OTF
  
  install -d ${CACHE_PATH}/usr/share/fonts/TTF
  install -m644 *.ttf ${CACHE_PATH}/usr/share/fonts/TTF
}
