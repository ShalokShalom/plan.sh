pkg_origin=

pkg_name=masterpdfeditor
pkg_version=4.2.12
pkg_description="Complete solution for creation and editing PDF files. (Free for non-commercial use)"
pkg_upstream_url="https://code-industry.net/free-pdf-editor.php"
pkg_license=('custom')
pkg_deps=('qt5-base')
pkg_source=("http://get.code-industry.net/public/master-pdf-editor-${pkg_version}_qt5.amd64.tar.gz"
        'masterpdfeditor.desktop')
sha1sums=('80156763bac2ed0183c5b758834fa32f25557023'
          'a6fbae4adf9cffea181f2e9f5585364456049577')

do_package() {
	mkdir -p ${pkg_prefix}/opt/masterpdfeditor
	cd master-pdf-editor-4
	
	/bin/tar cf - * | ( cd ${pkg_prefix}/opt/masterpdfeditor; tar xfp - )
	install -D -m755 ${CACHE_PATH}/master-pdf-editor-4/lang/*.qm ${pkg_prefix}/opt/masterpdfeditor/lang
	install -D -m755 ${CACHE_PATH}/master-pdf-editor-4/lang/*.ts ${pkg_prefix}/opt/masterpdfeditor/lang
	install -D -m644 ${CACHE_PATH}/master-pdf-editor-4/license.txt ${pkg_prefix}/usr/share/licenses/masterpdfeditor/LICENSE
	install -D -m644 ${CACHE_PATH}/master-pdf-editor-4/masterpdfeditor4.png ${pkg_prefix}/usr/share/pixmaps/pdfeditor.png
	install -D -m644 ${CACHE_PATH}/masterpdfeditor.desktop ${pkg_prefix}/usr/share/applications/masterpdfeditor.desktop
	rm ${pkg_prefix}/opt/masterpdfeditor/license.txt
	mkdir -p ${pkg_prefix}/usr/bin
	ln -s /opt/masterpdfeditor/masterpdfeditor4 ${pkg_prefix}/usr/bin/pdfeditor
}
