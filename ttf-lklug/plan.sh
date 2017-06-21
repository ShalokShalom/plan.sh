pkg_origin=cosmos

pkg_name=ttf-lklug
pkg_version=1.0
pkg_description="Unicode sinhala font"
pkg_upstream_url="http://sinhala.sourceforge.net/"
pkg_license=('GPL')
pkg_deps=('fontconfig' 'xorg-font-utils')
install=ttf.install
pkg_source=("http://sinhala.sourceforge.net/files/lklug.ttf")
pkg_shasum=('3bfe4e498d6daa90a4ed956daaa10fef')

do_package() {
	mkdir -p $CACHE_PATH/usr/share/fonts/TTF
	cp $CACHE_PATH/lklug.ttf $CACHE_PATH/usr/share/fonts/TTF
}
