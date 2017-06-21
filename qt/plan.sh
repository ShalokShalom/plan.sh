pkg_origin=cosmos

## rebuild on icu update

pkgbase=qt
pkg_name=('qt' 'qt-private-headers')
pkg_version=4.8.7
_pkg_version=4.8.7
pkg_upstream_url='http://qt.nokia.com/'
pkg_license=('GPL3' 'LGPL')
pkg_build_deps=('libtiff' 'libpng' 'libmng' 'sqlite3' 'ca-certificates' 'glib2' 'dbus'
    'fontconfig' 'libgl' 'libsm' 'libxrandr' 'libxv' 'libxi' 'alsa-lib'
    'xdg-utils' 'hicolor-icon-theme' 'desktop-file-utils' 'mesa' 'postgresql-libs'
    'mysql' 'unixodbc' 'cups' 'libxinerama' 'libxcursor')
_pkgfqn="qt-everywhere-opensource-src-${_pkg_version}"
pkg_source=("http://download.qt-project.org/official_releases/qt/4.8/${_pkg_version}/qt-everywhere-opensource-src-${_pkg_version}.tar.gz"
        'assistant.desktop' 'designer.desktop' 'linguist.desktop'
        'qtconfig.desktop' 'improve-cups-support.patch' 'qt_no_debug.patch'
        'qkeymapper.patch'
        'qsystemtrayicon-plugin-system-4.7.4.diff')
pkg_shasum=('d990ee66bf7ab0c785589776f35ba6ad'
         'fc211414130ab2764132e7370f8e5caa'
         '85179f5e0437514f8639957e1d8baf62'
         'f11852b97583610f3dbb669ebc3e21bc'
         '6b771c8a81dd90b45e8a79afa0e5bbfd'
         'b9fb6b953cec428d59c026b1ef370e86'
         '742bfebaebc44c26f6cabe654f702cc8'
         '62b3744759c0729042c54d79826f6389'
         '576f029ee4bffbd12e78d7df097feb55')

do_build() {
	patch -p1 -i "${CACHE_PATH}"/improve-cups-support.patch

        # from Fedora, removing "QDBusConnection:..." message for qt apps
	patch -p1 -i "${CACHE_PATH}"/qt_no_debug.patch
	# non latin keyboard shortcuts bug 
	# https://bugreports.qt-project.org/browse/QTBUG-32908
	#patch -p1 -i "${CACHE_PATH}"/qkeymapper.patch
	
	#systemtray support in kf5 for Qt4
	#http://bazaar.launchpad.net/~indicator-applet-developers/sni-qt/trunk.13.04/view/head:/README
	patch -p1 -i "${CACHE_PATH}"/qsystemtrayicon-plugin-system-4.7.4.diff

        export QT4DIR="${CACHE_PATH}"/${_pkgfqn}
        export LD_LIBRARY_PATH=${QT4DIR}/lib:${LD_LIBRARY_PATH}

        sed -i "s|-O2|${CXXFLAGS}|" mkspecs/common/{g++,gcc}-base.conf
        sed -i "/^QMAKE_LFLAGS_RPATH/s| -Wl,-rpath,||g" mkspecs/common/gcc-base-unix.conf
        sed -i "/^QMAKE_LFLAGS\s/s|+=|+= ${LDFLAGS}|g" mkspecs/common/gcc-base.conf

	./configure -confirm-license -opensource \
		-prefix /usr \
		-docdir /usr/share/doc/qt \
		-plugindir /usr/lib/qt/plugins \
		-importdir /usr/lib/qt/imports \
		-datadir /usr/share/qt \
		-translationdir /usr/share/qt/translations \
		-sysconfdir /etc/xdg \
		-examplesdir /usr/share/doc/qt/examples \
		-demosdir /usr/share/doc/qt/demos \
		-plugin-sql-{psql,mysql,sqlite,odbc} \
		-system-sqlite \
		-no-phonon \
		-no-phonon-backend \
		-no-webkit \
		-graphicssystem raster \
                 -openssl-linked \
                 -nomake demos \
                 -nomake examples \
                 -nomake docs \
                 -silent \
                 -no-rpath \
                 -optimized-qmake \
                 -reduce-relocations \
                 -dbus-linked \
                 -no-openvg \
                 -xcursor
	 make
}

package_qt() {
    pkg_description='A cross-platform application and UI framework'
    pkg_deps=('libtiff' 'libpng' 'libmng' 'sqlite3' 'ca-certificates' 'glib2' 'dbus'
             'fontconfig' 'libgl' 'libsm' 'libxrandr' 'libxv' 'libxi' 'alsa-lib'
             'xdg-utils' 'hicolor-icon-theme' 'desktop-file-utils' 'libxinerama' 'libxcursor')
    install='qt.install'
	
	make INSTALL_ROOT=$CACHE_PATH install

	# install missing icons and desktop files
	for icon in tools/linguist/linguist/images/icons/linguist-*-32.png ; do
		size=$(echo $(basename ${icon}) | cut -d- -f2)
		install -p -D -m644 ${icon} ${CACHE_PATH}/usr/share/icons/hicolor/${size}x${size}/apps/linguist.png
	done
	install -p -D -m644 src/gui/dialogs/images/qtlogo-64.png ${CACHE_PATH}/usr/share/icons/hicolor/64x64/apps/qtlogo.png
	install -p -D -m644 tools/assistant/tools/assistant/images/assistant.png ${CACHE_PATH}/usr/share/icons/hicolor/32x32/apps/assistant.png
	install -p -D -m644 tools/designer/src/designer/images/designer.png ${CACHE_PATH}/usr/share/icons/hicolor/128x128/apps/designer.png
	#install -d ${CACHE_PATH}/usr/share/applications
	#install -m644 ${CACHE_PATH}/{linguist,designer,assistant,qtconfig}.desktop ${CACHE_PATH}/usr/share/applications/

	# install license addition
	install -D -m644 LGPL_EXCEPTION.txt ${CACHE_PATH}/usr/share/licenses/qt/LGPL_EXCEPTION.txt

	# Fix wrong path in pkgconfig files
	find ${CACHE_PATH}/usr/lib/pkgconfig -type f -name '*.pc' \
		-exec perl -pi -e "s, -L${CACHE_PATH}/?\S+,,g" {} \;
	# Fix wrong path in prl files
	find ${CACHE_PATH}/usr/lib -type f -name '*.prl' \
		-exec sed -i -e '/^QMAKE_PRL_BUILD_DIR/d;s/\(QMAKE_PRL_LIBS =\).*/\1/' {} \;
}

package_qt-private-headers() {
    pkg_description="Qt private headers for development"
    pkg_deps=("qt=${pkg_version}")

    install -d ${CACHE_PATH}/usr/include/{QtCore,QtDeclarative,QtGui,QtScript}
    install -d ${CACHE_PATH}/usr/src/{corelib,declarative,gui,script}
    
    for i in QtCore QtDeclarative QtGui QtScript; do
      cp -r ${CACHE_PATH}/$_pkgfqn/include/${i}/private/ \
        ${CACHE_PATH}/usr/include/${i}/
    done

    for i in corelib declarative gui script; do
      cp -r ${CACHE_PATH}/$_pkgfqn/src/${i} ${CACHE_PATH}/usr/src/
    done
}

