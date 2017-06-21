pkg_origin=

pkg_name=('wallpapers-midna')
pkg_version=0.2
pkg_description="Litho Flowers themed wallpaper"
pkg_upstream_url="http://kasox.us"
pkg_license=('GPL')
pkg_source=("http://sourceforge.net/projects/kaosx/files/sources/midna/wallpaper/${pkg_version}/midna.tar.xz")
pkg_shasum=('6e70664ae696273defe74a4e3670527f')

do_package() {
	cd ${CACHE_PATH}/midna
	
	mkdir -pv ${pkg_prefix}/usr/share/wallpapers/midna/contents/
	cd ${CACHE_PATH}/midna/contents
	cp -Rv * ${pkg_prefix}/usr/share/wallpapers/midna/contents/
	cd $pkg_prefix/usr/share/wallpapers/midna/contents/

	cp -v ${CACHE_PATH}/midna/metadata.desktop $pkg_prefix/usr/share/wallpapers/midna
	cp -v ${CACHE_PATH}/midna/contents/screenshot.png $pkg_prefix/usr/share/wallpapers/midna/contents
}
