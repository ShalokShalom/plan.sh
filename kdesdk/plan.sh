pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkgbase=('kdesdk')
pkg_name=('kdesdk-cervisia'
	 'kdesdk-dolphin-plugins'
         'kdesdk-kapptemplate'
         'kdesdk-kcachegrind' 
         'kdesdk-kioslaves'
         'kdesdk-kmtrace'
         'kdesdk-kompare'
         'kdesdk-kpartloader'
         'kdesdk-kprofilemethod'
         'kdesdk-kstartperf'
         'kdesdk-kuiviewer'
         'kdesdk-lokalize'
         'kdesdk-poxml'
         'kdesdk-scripts'
         'kdesdk-strigi-analyzers'
	 'kdesdk-thumbnailers'
         'kdesdk-umbrello')

pkg_version=${_kdever}

pkg_description="KDE Standard Development Toolkit"
pkg_upstream_url="http://www.kde.org"
pkg_license=('GPL' 'LGPL' 'FDL')


pkg_build_deps=('pkgconfig' 'cmake' 'automoc4' 'boost' 'kde-runtime' 'antlr2' 'hunspell'
             'kdepimlibs' 'subversion' 'kdebindings-pykde4'
             'kde-baseapps-konqueror' 'java-runtime' 'docbook-xsl')

pkg_source=("$_mirror/${pkgbase}-$_kdever.tar.xz")
pkg_shasum=(`grep ${pkgbase}-$_kdever.tar.xz ../kde-sc.md5 | cut -d" " -f1`)

do_build() {
	cd ${CACHE_PATH}/${pkgbase}-${pkg_version}

	msg "starting build ..."
	cmake . -DCMAKE_BUILD_TYPE=${_build_type} \
		-DCMAKE_INSTALL_PREFIX=${_installprefix} \
		-DCMAKE_SKIP_RPATH=ON 
	make 
}


package_kdesdk-dolphin-plugins() {
	pkg_description='Extra Dolphin plugins'
	pkg_deps=("kde-baseapps-dolphin>=${_kdever}" 'subversion' 'git' "kdesdk-kompare>=${_kdever}")
        optpkg_deps=('bzr: bazaar support'
                    'git: git support'
                    'mercurial: hg support'
                    'subversion: svn support')
        groups=('programming')
	install=${pkgbase}.install

	splitdirs="git svn bazaar hg"
		for i in ${splitdirs} ; do
			cd ${CACHE_PATH}/${pkgbase}-${pkg_version}/dolphin-plugins/${i}
			make DESTDIR=${pkg_prefix} install 
		done
}

package_kdesdk-cervisia() {
	pkg_description="A CVS GUI frontend for KDE"
	screenshot="http://www.kde.org/images/screenshots/cervisia.png"
	pkg_deps=("kde-runtime>=${_kdever}")
	groups=("kde" "kde-devel" "kde-uninstall" "kdesdk")
	groups=('programming')
        conflicts=('kdesdk-doc')
	install=${pkgbase}.install

	cd ${CACHE_PATH}/${pkgbase}-${pkg_version}/cervisia
	make DESTDIR=${pkg_prefix} install 
}

package_kdesdk-kapptemplate() {
	pkg_description="KDE application template generator"
	screenshot="http://www.kde.org/images/screenshots/kapptemplate.png"
	pkg_deps=("kde-runtime>=${_kdever}")
	groups=("kde" "kde-devel" "kde-uninstall" "kdesdk")
	groups=('programming')
        conflicts=('kdesdk-doc')
	install=${pkgbase}.install

	cd ${CACHE_PATH}/${pkgbase}-${pkg_version}/kapptemplate
	make DESTDIR=${pkg_prefix} install 
}

package_kdesdk-kcachegrind() {
	pkg_description="KDE profiler visualization"
	screenshot="http://www.kde.org/images/screenshots/kcachegrind.png"
	pkg_deps=("kde-runtime>=${_kdever}" "python2")
	groups=("kde" "kde-devel" "kde-uninstall" "kdesdk")
	groups=('programming')
        conflicts=('kdesdk-doc')
	install=${pkgbase}.install

	cd ${CACHE_PATH}/${pkgbase}-${pkg_version}/kcachegrind
	make DESTDIR=${pkg_prefix} install 
}

package_kdesdk-kdeaccounts-plugin() {
	pkg_description="Addressbook plugin that puts names/email addresses of all KDE SVN accounts into an addressbook"
	pkg_deps=("kde-runtime>=${_kdever}")
	groups=("kde" "kde-devel" "kde-uninstall" "kdesdk")
	groups=('programming')
	install=${pkgbase}.install

	cd ${CACHE_PATH}/${pkgbase}-${pkg_version}/kdeaccounts-plugin
	make DESTDIR=${pkg_prefix} install
}

package_kdesdk-kdepalettes() {
	pkg_description='Palettes for the Gimp that match the KDE standard color palette'
	optpkg_deps=('gimp')

	install -D -m644 $CACHE_PATH/${pkgbase}-${pkg_version}/kdepalettes/KDE_Gimp \
		$pkg_prefix/usr/share/gimp/2.0/palettes/KDE.gpl
}

package_kdesdk-kioslaves() {
	pkg_description='KDED Subversion Module'
	pkg_deps=("kde-runtime>=${_kdever}" 'subversion')
	groups=('programming')
	provides=('kdesdk-kioslave')
        conflicts=('kdesdk-common' 'kdesdk-kioslave')
	replaces=('kdesdk-common' 'kdesdk-kioslave')

	cd ${CACHE_PATH}/${pkgbase}-${pkg_version}/kdesdk-kioslaves
	make DESTDIR=${pkg_prefix} install 
}

package_kdesdk-kmtrace() {
	pkg_description="A KDE memory leak tracer"
	pkg_deps=("kde-runtime>=${_kdever}")
	groups=("kde" "kde-devel" "kde-uninstall" "kdesdk")
	groups=('programming')
        conflicts=('kdesdk-doc')
	install=${pkgbase}.install

	cd ${CACHE_PATH}/${pkgbase}-${pkg_version}/kde-dev-utils/kmtrace
	make DESTDIR=${pkg_prefix} install 
}

package_kdesdk-kompare() {
	pkg_description="A KDE visual diff viewer"
	screenshot="http://www.kde.org/images/screenshots/kompare.png"
	pkg_deps=("kde-runtime>=${_kdever}")
	groups=("kde" "kde-devel" "kde-uninstall" "kdesdk")
	groups=('programming')
        conflicts=('kdesdk-doc')
	install=${pkgbase}.install

        cd ${CACHE_PATH}/${pkgbase}-${pkg_version}/kompare
	make DESTDIR=${pkg_prefix} install
}

package_kdesdk-kpartloader() {
	pkg_description="KPartloader is a very simple application to test loading of a KPart."
	pkg_deps=("kde-runtime>=${_kdever}")
	groups=("kde" "kde-devel" "kde-uninstall" "kdesdk")
	groups=('programming')
	install=${pkgbase}.install

	cd ${CACHE_PATH}/${pkgbase}-${pkg_version}/kde-dev-utils/kpartloader
	make DESTDIR=${pkg_prefix} install 
}

package_kdesdk-kprofilemethod() {
	pkg_description="Macros for profiling using QTime"
	pkg_deps=("kde-runtime>=${_kdever}")
	groups=("kde" "kde-devel" "kde-uninstall" "kdesdk")
	groups=('programming')
	install=${pkgbase}.install

	cd ${CACHE_PATH}/${pkgbase}-${pkg_version}/kde-dev-utils/kprofilemethod
	make DESTDIR=${pkg_prefix} install 
}

package_kdesdk-kspy() {
	pkg_description='An Object Inspector for Qt/KDE applications'
        pkg_deps=("kde-runtime>=${_kdever}")
        groups=("kde" "kde-devel" "kde-uninstall" "kdesdk")
        groups=('programming')
        install=${pkgbase}.install

        cd ${CACHE_PATH}/${pkgbase}-${pkg_version}/kdesdk-kspy
        make DESTDIR=${pkg_prefix} install 
}

package_kdesdk-kstartperf() {
	pkg_description="Measures startup time for KDE applications"
	pkg_deps=("kde-runtime>=${_kdever}")
	groups=("kde" "kde-devel" "kde-uninstall" "kdesdk")
	groups=('programming')
	install=${pkgbase}.install

	cd ${CACHE_PATH}/${pkgbase}-${pkg_version}/kde-dev-utils/kstartperf
	make DESTDIR=${pkg_prefix} install 
}

package_kdesdk-kuiviewer() {
	pkg_description="KUIViewer is a utility to display and test .ui-files"
	screenshot="http://www.kde.org/images/screenshots/kuiviewer.png"
	pkg_deps=("kde-runtime>=${_kdever}")
	groups=("kde" "kde-devel" "kde-uninstall" "kdesdk")
	groups=('programming')
	install=${pkgbase}.install

	cd ${CACHE_PATH}/${pkgbase}-${pkg_version}/kde-dev-utils/kuiviewer
	make DESTDIR=${pkg_prefix} install 
}

package_kdesdk-lokalize() {
	pkg_description="Computer aided translation system"
	screenshot="http://www.kde.org/images/screenshots/lokalize.png"
	pkg_deps=("kde-runtime>=${_kdever}" "kdebindings-pykde4>=${_kdever}" "kdesdk-strigi-analyzers>=${_kdever}" "hunspell")
	optpkg_deps=('translate-toolkit: enable extra python script')
        conflicts=('kdesdk-doc')
	groups=("kde" "kde-devel" "kde-uninstall" "kdesdk")
	groups=('programming')
	install=${pkgbase}.install

	cd ${CACHE_PATH}/${pkgbase}-${pkg_version}/lokalize
	make DESTDIR=${pkg_prefix} install 
}

package_kdesdk-okteta() {
	pkg_description="Okteta is a simple editor for the raw data of files, also known as a hex editor."
	screenshot="http://www.kde.org/images/screenshots/okteta.png"
	pkg_deps=("kde-runtime>=${_kdever}" "kde-runtime>=${_kdever}"
		 "kde-baseapps>=${_kdever}")
	replaces=('kdeutils-okteta')
        conflicts=('kdesdk-doc')
	groups=("kde" "kde-devel" "kdesdk" "kde-uninstall")
	install=${pkgbase}.install

	cd ${CACHE_PATH}/${pkgbase}-${pkg_version}/okteta
	make DESTDIR=${pkg_prefix} install 
}

package_kdesdk-poxml() {
	pkg_description="Tools for using .po-files to translate DocBook XML files"
	pkg_deps=("kde-runtime>=${_kdever}" 'qt' 'antlr2')
        conflicts=('kdesdk-doc')
	groups=("kde" "kde-devel" "kde-uninstall" "kdesdk")
	groups=('programming')
	install=${pkgbase}.install

	cd ${CACHE_PATH}/${pkgbase}-${pkg_version}/poxml
	make DESTDIR=${pkg_prefix} install 
}

package_kdesdk-scripts() {
	pkg_description="Extra scripts for the KDE SDK"
	pkg_deps=("kde-runtime>=${_kdever}" 'python')
        conflicts=('kdesdk-doc')
	groups=("kde" "kde-devel" "kde-uninstall" "kdesdk")
	groups=('programming')
	install=${pkgbase}.install

	cd ${CACHE_PATH}/${pkgbase}-${pkg_version}/kde-dev-scripts
	make DESTDIR=${pkg_prefix} install 
}


package_kdesdk-strigi-analyzers() {
	pkg_description='Strigi-Analyzer for KDE SDK'
	pkg_deps=("kdelibs>=${_kdever}")
	provides=('kdesdk-strigi-analyzer')
	replaces=('kdesdk-strigi-analyzer')
	conflicts=('kdesdk-common' 'kdesdk-strigi-analyzer')

	cd ${CACHE_PATH}/${pkgbase}-${pkg_version}/kdesdk-strigi-analyzers
	make DESTDIR=${pkg_prefix} install 
}

package_kdesdk-thumbnailers() {
        pkg_description="KDE SDK thumbnailers for several development files"
        pkg_deps=("kde-runtime>=${_kdever}")
        groups=("kde" "kde-devel" "kde-uninstall" "kdesdk")
        groups=('programming')
        install=${pkgbase}.install
        replaces=('po-thumbnailer')
        conflicts=('po-thumbnailer')
        provides=('po-thumbnailer')

        cd ${CACHE_PATH}/${pkgbase}-${pkg_version}/kdesdk-thumbnailers
        make DESTDIR=${pkg_prefix} install 
}

package_kdesdk-umbrello() {
	pkg_description="An UML modeling tool for KDE"
	screenshot="http://uml.sourceforge.net/screenshots/umbrello-2.0.png"
	pkg_deps=("kde-runtime>=${_kdever}")
        conflicts=('kdesdk-doc')
	groups=("kde" "kde-devel" "kde-uninstall" "kdesdk")
	groups=('programming')
	install=${pkgbase}.install

	cd ${CACHE_PATH}/${pkgbase}-${pkg_version}/umbrello
	make DESTDIR=${pkg_prefix} install 
}
