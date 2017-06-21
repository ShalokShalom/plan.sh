pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkgbase=('kdenetwork')
pkg_name=('kdenetwork-filesharing'
         'kdenetwork-kdnssd'
         'kdenetwork-kget'
         'kdenetwork-kopete'
         'kdenetwork-kppp'
         'kdenetwork-krdc'
         'kdenetwork-krfb')
pkg_version=${_kdever}
pkg_description="split package"
pkg_upstream_url="http://www.kde.org"
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_build_deps=('pkg-config' 'cmake' 'automoc4' 'boost' 'speex' 'ortp' 'libotr' 'qca-ossl' 'telepathy-qt'
	     "kde-workspace>=${_kdever}" "kde-baseapps>=${_kdever}" 'libvncserver' 'libmsn' 'libmms'
	     'ppp' 'v4l-utils' 'libidn' 'rdesktop' 'qimageblitz' 'libxss' 'libxdamage' 'libgadu'
	     'mediastreamer' 'kwebkitpart' 'libktorrent' 'docbook-xsl')
pkg_source=("$_mirror/${pkgbase}-$_kdever.tar.xz")
pkg_shasum=(`grep ${pkgbase}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_build() {
	cd ${CACHE_PATH}/${pkgbase}-${pkg_version}
	
	msg "starting build ..."
	cmake . -DCMAKE_BUILD_TYPE=${_build_type} \
		-DCMAKE_INSTALL_PREFIX=${_installprefix} \
		-DWITH_Xmms=OFF \
		-DWITH_qq=OFF \
		-DWITH_meanwhile=OFF \
		-DCMAKE_SKIP_RPATH=ON \
		-DCMAKE_{SHARED,MODULE,EXE}_LINKER_FLAGS='-Wl,--no-undefined -Wl,--as-needed'

	make 
}

package_kdenetwork-filesharing() {
	pkg_description='Konqueror properties dialog plugin to share a directory with the local network'
	pkg_deps=("kdelibs>=${_kdever}" 'samba')
	groups=('kde' "${pkgbase}" 'kde-uninstall' 'network')
	splitdirs="filesharing"
		for i in ${splitdirs} ; do
			cd ${CACHE_PATH}/${pkgbase}-${pkg_version}/${i}
			make DESTDIR=${pkg_prefix} install 
		done
}

package_kdenetwork-kdnssd() {
	pkg_description='Monitors the network for DNS-SD services'
	pkg_deps=("kdelibs>=${_kdever}")
	groups=('kde' "${pkgbase}" 'kde-uninstall' 'network')
	splitdirs="kdnssd"
		for i in ${splitdirs} ; do
			cd ${CACHE_PATH}/${pkgbase}-${pkg_version}/${i}
			make DESTDIR=${pkg_prefix} install 
		done
}

package_kdenetwork-kget() {
	pkg_description="Download manager"
	pkg_upstream_url="http://kde.org/applications/internet/kget/"
	pkg_deps=("kde-workspace>=${_kdever}" 'qca' 'kwebkitpart>=0.9.6' 'libktorrent>=1.0.4' 'libmms')
	groups=('kde' "${pkgbase}" 'kde-uninstall' 'network')
	install=${pkgbase}.install
	splitdirs="kget doc/kget"
		for i in ${splitdirs} ; do
			cd ${CACHE_PATH}/${pkgbase}-${pkg_version}/${i}
			make DESTDIR=${pkg_prefix} install 
		done
}

package_kdenetwork-kopete() {
	pkg_description="Kopete, the instant messenger"
	pkg_upstream_url="http://kde.org/applications/internet/kopete/"
	pkg_deps=("kde-runtime>=${_kdever}" "kdepimlibs>=${_kdever}"
	         'qca-ossl' 'libotr' 'libmsn' 'libidn' 'qimageblitz' 'libxss'
                  'v4l-utils' 'mediastreamer' 'libgadu')
	groups=('kde' "${pkgbase}" 'kde-uninstall' 'communication')
	install=${pkgbase}.install
	splitdirs="kopete doc/kopete"
		for i in ${splitdirs} ; do
			cd ${CACHE_PATH}/${pkgbase}-${pkg_version}/${i}
			make DESTDIR=${pkg_prefix} install 
		done
}

package_kdenetwork-kppp() {
	pkg_description="PPP Client"
	pkg_upstream_url="http://kde.org/applications/internet/kppp/"
	pkg_deps=("kde-runtime>=${_kdever}" 'ppp')
	groups=('kde' "${pkgbase}" 'kde-uninstall' 'network')
	install=${pkgbase}.install
	splitdirs="kppp doc/kppp"
		for i in ${splitdirs} ; do
			cd ${CACHE_PATH}/${pkgbase}-${pkg_version}/${i}
			make DESTDIR=${pkg_prefix} install 
		done
}

package_kdenetwork-krdc() {
	pkg_description="Desktop Sharing Client"
	pkg_upstream_url="http://kde.org/applications/internet/krdc/"
	pkg_deps=("kde-runtime>=${_kdever}" 'libvncserver' 'rdesktop' 'telepathy-qt')
	groups=('kde' "${pkgbase}" 'kde-uninstall' 'network')
	install=${pkgbase}.install
	splitdirs="krdc doc/krdc"
		for i in ${splitdirs} ; do
			cd ${CACHE_PATH}/${pkgbase}-${pkg_version}/${i}
			make DESTDIR=${pkg_prefix} install 
		done
}

package_kdenetwork-krfb() {
	pkg_description="Desktop Sharing Server"
	pkg_deps=("kde-runtime>=${_kdever}" "kdelibs>=${_kdever}" 'libvncserver' 'libxdamage')
	groups=('kde' "${pkgbase}" 'kde-uninstall' 'network')
	install=${pkgbase}.install
	splitdirs="krfb doc/krfb"
		for i in ${splitdirs} ; do
			cd ${CACHE_PATH}/${pkgbase}-${pkg_version}/${i}
			make DESTDIR=${pkg_prefix} install 
		done
}
