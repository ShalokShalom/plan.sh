pkg_origin=cosmos

pkg_name=ttf-google-fonts
pkg_version=20161115
_commit=d9f970f66c8a6d2f7ca683948401ce854a5844be
pkg_description="TrueType fonts from the Google Fonts project"
pkg_upstream_url="https://github.com/google/fonts"
pkg_license=('various')
pkg_deps=('fontconfig' 'xorg-fonts-encodings' 'xorg-mkfontdir' 'xorg-mkfontscale')
pkg_build_deps=('git')
install=${pkg_name}.install
pkg_source=("https://github.com/google/fonts/archive/${_commit}.zip")
pkg_shasum=('b65e4c3c8d95bc1aa2ae6e542903da63')

do_package() {
  install -dm755 ${CACHE_PATH}/usr/share/fonts/TTF
  find . -type f -name \*.ttf -exec install -Dm644 '{}' \
    ${CACHE_PATH}/usr/share/fonts/TTF \;

  # remove droid, noto & cantarell font packages provided files
  find ${CACHE_PATH}/usr/share/fonts/TTF -type f -name "Cantarell-*.ttf" -delete
  find ${CACHE_PATH}/usr/share/fonts/TTF -type f -name "Droid*.ttf" -delete
  find ${CACHE_PATH}/usr/share/fonts/TTF -type f -name "Noto*.ttf" -delete
  
  find . -type f -name OFL.txt -exec install -Dm644 '{}' \
    ${CACHE_PATH}/usr/share/licenses/${pkg_name}/{} \;
  install -Dm644 ${CACHE_PATH}/fonts-${_commit}/ufl/ubuntu/UFL.txt \
    ${CACHE_PATH}/usr/share/licenses/${pkg_name}/UFL.txt
}
