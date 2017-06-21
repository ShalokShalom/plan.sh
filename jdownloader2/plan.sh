pkg_origin=
pkg_name=jdownloader2
pkg_version=20160701
pkg_description='Download manager for one-click hosting sites, uses its own updater.'
pkg_upstream_url='http://jdownloader.org/'
pkg_license=('GPL')
pkg_deps=('sh' 'desktop-file-utils' 'hicolor-icon-theme' 'java-runtime' 'shared-mime-info' 'wget' 'unzip')
install='jdownloader.install'
pkg_source=('JDownloader'
        'jdownloader.xml'
        'jdownloader.desktop'
        'jd-containers.desktop'
        'icons.tar.xz')
pkg_shasum=('6266bd6d9c4323d66922654ae3a3a40b'
         '9b9cce683d2c4e694dfb9cf39843c4aa'
         'e3243f1ca1024e398a97646390bb40f1'
         'ca8bbf4e299a680098ed86e7743be634'
         '0a854bfe80516c621b3f5bd25f3838ee')
         
do_package() {
	install -D -m755 "$CACHE_PATH/JDownloader" "$pkg_prefix/usr/bin/JDownloader"
	install -D -m644 "$CACHE_PATH/jdownloader.xml" "$pkg_prefix/usr/share/mime/packages/jdownloader.xml"
	install -D -m644 "$CACHE_PATH/jdownloader.desktop" "$pkg_prefix/usr/share/applications/jdownloader.desktop"
	install -D -m644 "$CACHE_PATH/jd-containers.desktop" "$pkg_prefix/usr/share/applications/jd-containers.desktop"
	install -D -m644 "$CACHE_PATH/icons/jd-container16.png" "$pkg_prefix/usr/share/icons/hicolor/16x16/mimetypes/jd-container.png"
	install -D -m644 "$CACHE_PATH/icons/jd-container22.png" "$pkg_prefix/usr/share/icons/hicolor/22x22/mimetypes/jd-container.png"
	install -D -m644 "$CACHE_PATH/icons/jd-container24.png" "$pkg_prefix/usr/share/icons/hicolor/24x24/mimetypes/jd-container.png"
	install -D -m644 "$CACHE_PATH/icons/jd-container32.png" "$pkg_prefix/usr/share/icons/hicolor/32x32/mimetypes/jd-container.png"
	install -D -m644 "$CACHE_PATH/icons/jd-container48.png" "$pkg_prefix/usr/share/icons/hicolor/48x48/mimetypes/jd-container.png"
	install -D -m644 "$CACHE_PATH/icons/jd-container256.png" "$pkg_prefix/usr/share/icons/hicolor/256x256/mimetypes/jd-container.png"
	install -D -m644 "$CACHE_PATH/icons/jdownloader16.png" "$pkg_prefix/usr/share/icons/hicolor/16x16/apps/jdownloader.png"
	install -D -m644 "$CACHE_PATH/icons/jdownloader22.png" "$pkg_prefix/usr/share/icons/hicolor/22x22/apps/jdownloader.png"
	install -D -m644 "$CACHE_PATH/icons/jdownloader24.png" "$pkg_prefix/usr/share/icons/hicolor/24x24/apps/jdownloader.png"
	install -D -m644 "$CACHE_PATH/icons/jdownloader32.png" "$pkg_prefix/usr/share/icons/hicolor/32x32/apps/jdownloader.png"
	install -D -m644 "$CACHE_PATH/icons/jdownloader48.png" "$pkg_prefix/usr/share/icons/hicolor/48x48/apps/jdownloader.png"
	install -D -m644 "$CACHE_PATH/icons/jdownloader256.png" "$pkg_prefix/usr/share/icons/hicolor/256x256/apps/jdownloader.png"
	install -d -m777 "$pkg_prefix/opt/JDownloader"
}
