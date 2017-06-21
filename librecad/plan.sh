pkg_origin=

pkg_name=librecad
pkg_version=2.1.3
pkg_description="2D CAD drawing tool based on the community edition of QCad"
pkg_upstream_url="http://www.librecad.org/"
pkg_license=('GPL')
pkg_deps=('qt5-svg' 'muparser' 'qt5-tools')
pkg_build_deps=('boost' 'imagemagick')
pkg_source=("https://github.com/LibreCAD/LibreCAD/archive/${pkg_version}.tar.gz")
pkg_shasum=('cef168e90e247c4a20ec81dd9686110e')

do_build() {
	cd LibreCAD-${pkg_version}

	sed -i "/^SCMREVISION/c SCMREVISION=\"${pkg_version}\"" librecad/src/src.pro
	sed -i 's/qcollectiongenerator/qcollectiongenerator-qt5/g' scripts/postprocess-unix.sh
	sed -i 's/LRELEASE="lrelease"/LRELEASE="lrelease-qt5"/g' scripts/postprocess-unix.sh

	export CPPFLAGS="-std=c++0x"
	/usr/lib/qt5/bin/qmake librecad.pro
	make
}

do_package() {
	cd LibreCAD-${pkg_version}

	install -D -m0755 unix/librecad ${pkg_prefix}/usr/bin/librecad
	install -D -m0755 unix/ttf2lff ${pkg_prefix}/usr/bin/ttf2lff

	install -D -m0644 desktop/librecad.desktop ${pkg_prefix}/usr/share/applications/librecad.desktop
	install -D -m0644 desktop/librecad.1 ${pkg_prefix}/usr/share/man/man1/librecad.1

	for SIZE in 16 24 32 48 64 96 128; do
		convert -scale ${SIZE} \
			desktop/graphics_icons_and_splash/Icon\ LibreCAD/Icon_Librecad.svg \
			${CACHE_PATH}/librecad.png
		install -D -m0644 ${CACHE_PATH}/librecad.png ${pkg_prefix}/usr/share/icons/hicolor/${SIZE}x${SIZE}/apps/librecad.png
	done
	install -D -m0644 desktop/graphics_icons_and_splash/Icon\ LibreCAD/Icon_Librecad.svg ${pkg_prefix}/usr/share/icons/hicolor/scalable/apps/librecad.svg

	mkdir -p ${pkg_prefix}/usr/share/librecad/
	cp -r unix/resources/{library,patterns,fonts,qm} ${pkg_prefix}/usr/share/librecad/
}

