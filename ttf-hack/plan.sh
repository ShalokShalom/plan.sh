pkg_origin=cosmos

pkg_name=ttf-hack
_pkg_name=Hack
pkg_version=2.020
_pkg_version=2_020
pkg_description="Hack is hand groomed and optically balanced to be your go-to code face."
pkg_license=('Hack Open Font License v2.0 and the Bitstream Vera License')
pkg_upstream_url="http://sourcefoundry.org/hack/"
pkg_deps=('fontconfig' 'xorg-fonts-encodings' 'xorg-font-utils')
install=${pkg_name}.install
pkg_source=("https://github.com/chrissimpkins/Hack/releases/download/v${pkg_version}/${_pkg_name}-v${_pkg_version}-ttf.tar.xz"
        "https://raw.githubusercontent.com/chrissimpkins/Hack/master/LICENSE.md")
pkg_shasum=('627feaa52d5d760d18f0a6485e493826'
         'a44b1c2ef770d992b157c97dc5f2f084')

do_package() {
  install -d ${CACHE_PATH}/usr/share/fonts/TTF/
  install -D -m644 ${_pkg_name}*.ttf ${CACHE_PATH}/usr/share/fonts/TTF/
  
  install -D -m644 LICENSE.md ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE.md
}
