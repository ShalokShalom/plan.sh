pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name="kdemultimedia-thumbnailers"
pkg_description='KDE Thumbnailers for several formats'
pkg_version=${_kdever}
pkg_deps=('mplayer' 'ffmpeg' 'kdelibs')
pkg_upstream_url="http://www.kde.org"
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_build_deps=('pkg-config' 'cmake' 'automoc4' 'docbook-xsl')
pkg_source=($_mirror/ffmpegthumbs-$_kdever.tar.xz
	$_mirror/mplayerthumbs-$_kdever.tar.xz
	http://kenai.com/projects/kde-odf-thumbnail/downloads/download/1.0.0/kde-odf-thumbnail-1.0.0.tar.gz
	https://github.com/aclemens/GimpResourcesThumbnailer/archive/2.1.2.tar.gz
	http://kde-apps.org/CONTENT/content-files/145088-AudioThumbs-0.2.tar.gz
	mplayerthumbs-horizontal.patch
	sprocket-large.png
	sprocket-medium.png
	sprocket-small.png)
pkg_shasum=(`grep ffmpegthumbs-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`
	 `grep mplayerthumbs-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`
         'edf694939f4b5d5e97c3fe2f91e7cec3'
         'e2b66b6b9bf3514889cf456aac995602'
         'a9a5203916a6a03f25f53cf53b115f8c'
         '00ff1e8a1e4c1e39e3d1146f1d08036c'
         '6eeba61989d0e6904fe2c18bb01a3775'
         'ebb3b4c68ee69e128faf5ef0b37aaeae'
         '450cf7bf2ac02b1efe75156d9bb887f6')  # sprocket-small.png

do_build() {
        pushd ${CACHE_PATH}/ffmpegthumbs-${pkg_version}
        cmake . -DCMAKE_BUILD_TYPE=${_build_type} \
                -DCMAKE_INSTALL_PREFIX=${_installprefix} \
                -DCMAKE_{SHARED,MODULE,EXE}_LINKER_FLAGS='-Wl,--no-undefined -Wl,--as-needed'

        make VERBOSE=1 
        popd


	pushd ${CACHE_PATH}/mplayerthumbs-${pkg_version}
	msg "applying patches ..."
	patch -p2 -i ${CACHE_PATH}/mplayerthumbs-horizontal.patch 
        
	cmake . -DCMAKE_BUILD_TYPE=${_build_type} \
		-DCMAKE_INSTALL_PREFIX=${_installprefix} \
		-DCMAKE_{SHARED,MODULE,EXE}_LINKER_FLAGS='-Wl,--no-undefined -Wl,--as-needed'

	make VERBOSE=1 
	popd

	pushd $CACHE_PATH/kde-odf-thumbnail-1.0.0
	cmake . -DCMAKE_BUILD_TYPE=${_build_type} \
		-DCMAKE_INSTALL_PREFIX=${_installprefix} \
		-DCMAKE_SKIP_RPATH=ON \
		-DCMAKE_{SHARED,MODULE,EXE}_LINKER_FLAGS='-Wl,--no-undefined -Wl,--as-needed'
	popd

	pushd $CACHE_PATH/GimpResourcesThumbnailer-2.1.2
	cmake . -DCMAKE_BUILD_TYPE=${_build_type} \
		-DCMAKE_INSTALL_PREFIX=${_installprefix} \
		-DCMAKE_{SHARED,MODULE,EXE}_LINKER_FLAGS='-Wl,--no-undefined -Wl,--as-needed'
	popd

	pushd $CACHE_PATH/   #AudioThumbs-0.2
	cmake . -DCMAKE_BUILD_TYPE=${_build_type} \
		-DCMAKE_INSTALL_PREFIX=${_installprefix} \
		-DCMAKE_{SHARED,MODULE,EXE}_LINKER_FLAGS='-Wl,--no-undefined -Wl,--as-needed'
	popd
}

do_package() {
	splitdirs="mplayerthumbs ffmpegthumbs"
		for i in ${splitdirs} ; do
			cd ${CACHE_PATH}/${i}-${pkg_version}
			make DESTDIR=${pkg_prefix} install
		done

	install -D -m644 ${CACHE_PATH}/sprocket-large.png ${pkg_prefix}/usr/share/apps/videothumbnail/sprocket-large.png
	install -D -m644 ${CACHE_PATH}/sprocket-medium.png ${pkg_prefix}/usr/share/apps/videothumbnail/sprocket-medium.png
	install -D -m644 ${CACHE_PATH}/sprocket-small.png ${pkg_prefix}/usr/share/apps/videothumbnail/sprocket-small.png

	cd $CACHE_PATH/kde-odf-thumbnail-1.0.0
	make DESTDIR=${pkg_prefix} install 

	cd $CACHE_PATH/GimpResourcesThumbnailer-2.1.2
	make DESTDIR=${pkg_prefix} install 

	cd $CACHE_PATH/  #AudioThumbs-0.2
	make DESTDIR=${pkg_prefix} install 
}
