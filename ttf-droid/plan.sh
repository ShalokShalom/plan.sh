pkg_origin=cosmos

pkg_name=ttf-droid
_pkg_name=google-droid-fonts
pkg_version=20120715
pkg_description="A font created by Ascender Corporation for use by the Open Handset Alliance platform, Android."
pkg_license=('apache')
pkg_upstream_url="http://www.cosmix.org/software/"
pkg_deps=('fontconfig' 'xorg-fonts-encodings' 'xorg-font-utils')
install=${pkg_name}.install
pkg_source=("http://pkgs.fedoraproject.org/repo/pkgs/google-droid-fonts/google-droid-fonts-20120715.tar.xz/b1aef1f9f9bf61f521aeb4efd1239dd8/$_pkg_name-$pkg_version.tar.xz")
pkg_shasum=('b1aef1f9f9bf61f521aeb4efd1239dd8')

do_package() {
  
  install -d ${CACHE_PATH}/usr/share/fonts/TTF/
  install -m0644 *.ttf ${CACHE_PATH}/usr/share/fonts/TTF/
}
