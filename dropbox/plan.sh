pkg_origin=

pkg_name=dropbox
pkg_version=25.4.28
epoch=1
pkg_description="Free service that lets you bring your photos, docs, and videos anywhere and share them easily."
pkg_upstream_url="http://www.dropbox.com"
pkg_license=('custom')
pkg_deps=('dbus-glib' 'qt5-base' 'libsm' 'libxmu')
#pkg_source=("https://dl-web.dropbox.com/u/17/${pkg_name}-lnx.x86_64-${pkg_version}.tar.gz"
# get latest builds at https://www.dropboxforum.com/t5/Desktop-client-builds/bd-p/101003016
pkg_source=("https://dl.dropboxusercontent.com/u/17/dropbox-lnx.x86_64-${pkg_version}.tar.gz"
        "dropbox.png"
        "dropbox.desktop"
        "terms.txt"
        "dropbox.service")
pkg_shasum=('1816b71534744bfde2245752ea7ff84f'
         '9ec50da2ce59ed8c17606394b9c5e1c0'
         '20c97082211cf02af494043b93d5feb8'
         '5331288d5f5972dc2e9311d0f28dac76'
         '9061a4055570fc33d059dddec508b14a')

do_package() {
	install -d ${pkg_prefix}/opt
	cp -R ${CACHE_PATH}/.dropbox-dist/dropbox-lnx.x86_64-${pkg_version} ${pkg_prefix}/opt/dropbox

	find ${pkg_prefix}/opt/dropbox/ -type f -exec chmod 644 {} \;
	chmod 755 ${pkg_prefix}/opt/dropbox/dropboxd
	chmod 755 ${pkg_prefix}/opt/dropbox/dropbox

	install -d ${pkg_prefix}/usr/bin
	ln -s /opt/dropbox/dropboxd ${pkg_prefix}/usr/bin/dropboxd

	install -Dm644 ${CACHE_PATH}/dropbox.desktop ${pkg_prefix}/usr/share/applications/dropbox.desktop
	install -Dm644 ${CACHE_PATH}/dropbox.png ${pkg_prefix}/usr/share/pixmaps/dropbox.png
	install -Dm644 ${CACHE_PATH}/terms.txt ${pkg_prefix}/usr/share/licenses/$pkg_name/terms.txt
	install -Dm644 ${CACHE_PATH}/dropbox.service ${pkg_prefix}/usr/lib/systemd/system/dropbox@.service
}
