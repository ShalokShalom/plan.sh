pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kdelibs
pkg_version=4.14.20
pkg_description="KDE Core Libraries"
pkg_upstream_url="http://www.kde.org"
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=("${_qtpkg}>=${_qtver}" 'shared-mime-info' 'upower' 'udisks<2.0' 'xz' 'enchant' 'jasper'
         'openexr' 'giflib' 'strigi' 'libxtst' 'ca-certificates' 'xdg-utils' 'qca' 'polkit-qt'
         'libxss' 'phonon' 'attica' 'krb5' 'libxcursor' 'libutempter' 'hicolor-icon-theme'
         'libdbusmenu-qt' 'grantlee' 'media-player-info' 'qtwebkit' 'systemd' 'qtcurve4')
pkg_build_deps=('pkg-config' 'cmake' 'automoc4' 'intltool' 'avahi' 'libgl' 'aspell' 'hspell' 'docbook-xsl'
             'docbook-xml' 'bzip2' 'libzip')
optpkg_deps=('phonon-backend-gstreamer: GStreamer Phonon backend (default)'
	    'phonon-backend-vlc:       VLC Phonon backend'
	    'avahi:            Service discovery on your local network'
	    'aspell:           Spell checking'
	    'hspell:           Hebrew spell checking')
pkg_source=($_mirror/${pkg_name}-${pkg_version}.tar.xz
        '02_kde_applications_menu.patch'
        'MergeDir.patch'
        'kde.xml')
pkg_shasum=('06f0642f4f97d51b5fe6ed8123dda330'
         'e94450ba5430ea9c1e33bad9ae38ca2d'   # 02_kde_applications_menu.patch
         'f442698bae9d4ffb26f6df9457d7fc5a'   # MergeDir.patch
         '23d0ed25ff275d736dec48bb9bda70ad')
        
do_build() {
	# main patches
	msg "applying main patchset ..."
	cd ${CACHE_PATH}/${pkg_name}-${pkg_version}

	patch -p1 -i ${CACHE_PATH}/02_kde_applications_menu.patch

	# right positioning of applications' entries in kmenu
	patch -p1 -i ${CACHE_PATH}/MergeDir.patch

        cd ..
	rm -rf build
	mkdir -p build && cd build

	cmake ../${pkg_name}-${pkg_version} \
		-DCMAKE_BUILD_TYPE=${_build_type} \
		-DCMAKE_INSTALL_PREFIX=${_installprefix} \
		-DSYSCONF_INSTALL_DIR=/etc \
		-DHTML_INSTALL_DIR=/usr/share/doc/kde/html \
		-DKDE_DISTRIBUTION_TEXT='KaOS' \
		-DKDE_DEFAULT_HOME='.kde4' \
		-DWITH_FAM=OFF \
                -DWITH_HUpnp=OFF \
		-DCMAKE_SKIP_RPATH=ON \
		-DWITH_SOLID_UDISKS2=OFF \
		-DCMAKE_{SHARED,MODULE,EXE}_LINKER_FLAGS='-Wl,--no-undefined -Wl,--as-needed'

	make VERBOSE=1
}

do_package() {
	cd ${CACHE_PATH}/build

	make DESTDIR=${pkg_prefix} install

	# link cert bundle to the one from ca-certificates
	rm -f ${pkg_prefix}/usr/share/apps/kssl/ca-bundle.crt
	ln -sf /etc/ssl/certs/ca-certificates.crt ${pkg_prefix}/usr/share/apps/kssl/ca-bundle.crt
	# stop hook warnings, remove the all/all sections from default kde.xml
	rm -f ${pkg_prefix}/usr/share/mime/packages/kde.xml
	install -Dm644 ../kde.xml ${pkg_prefix}/usr/share/mime/packages/kde.xml
	
}
