pkg_origin=

pkg_name=opera
pkg_version=45.0.2552.898
pkg_description="A fast and secure web browser and Internet suite."
pkg_upstream_url="http://www.opera.com/browser/"
pkg_license=('custom:opera')
pkg_deps=('gcc-libs' 'libxt' 'freetype2' 'libxext' 'glib2' 'gconf' 'shared-mime-info' 'hicolor-icon-theme'
        'desktop-file-utils' 'gtk2' 'libnotify' 'chromium-ffmpeg-codecs')
pkg_source=("http://get.geo.opera.com.global.prod.fastly.net/pub/opera/desktop/${pkg_version}/linux/opera-stable_${pkg_version}_amd64.rpm")
pkg_shasum=('652dcfa9f497e881114810fb6b5a33c9')

do_package() {
	#bsdtar -xJf data.tar.xz -C ${pkg_prefix}/
	#chmod 4755 ${pkg_prefix}/usr/lib/x86_64-linux-gnu/opera/opera_sandbox
	
	install -dm755 ${pkg_prefix}/usr/lib
	cp -r usr/lib64/* ${pkg_prefix}/usr/lib/
	
	install -dm755 ${pkg_prefix}/usr/share
	cp -r usr/share/* ${pkg_prefix}/usr/share/
	
	install -dm755 ${pkg_prefix}/usr/bin
	ln -s /usr/lib/opera/opera ${pkg_prefix}/usr/bin/opera
	
	chmod 4755 ${pkg_prefix}/usr/lib/opera/opera_sandbox
	
	mkdir -p ${pkg_prefix}/usr/lib/opera/lib_extra
	ln -s /usr/lib/chromium/libs/libffmpeg.so ${pkg_prefix}/usr/lib/opera/lib_extra/libffmpeg.so
}
