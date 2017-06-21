pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

# original name (used for the source and pkg_names)
_origname=kde-l10n

pkgbase=('kde-l10n')
pkg_name=('kde-l10n-ar'
         'kde-l10n-ast'
	 'kde-l10n-bg'
	 'kde-l10n-bs'
	 'kde-l10n-ca'
	 'kde-l10n-ca@valencia'
	 'kde-l10n-cs'
##	 'kde-l10n-csb'
	 'kde-l10n-da'
	 'kde-l10n-de'
	 'kde-l10n-el'
	 'kde-l10n-en_gb'
	 'kde-l10n-eo'
	 'kde-l10n-es'
	 'kde-l10n-et'
	 'kde-l10n-eu'
	 'kde-l10n-fa'
	 'kde-l10n-fi'
	 'kde-l10n-fr'
##	 'kde-l10n-fy'
	 'kde-l10n-ga'
	 'kde-l10n-gl'
##	 'kde-l10n-gu'
	 'kde-l10n-he'
	 'kde-l10n-hi'
	 'kde-l10n-hr'
	 'kde-l10n-hu'
	 'kde-l10n-ia'
	 'kde-l10n-id'
	 'kde-l10n-is'
	 'kde-l10n-it'
	 'kde-l10n-ja'
	 'kde-l10n-kk'
	 'kde-l10n-km'
##	 'kde-l10n-kn'
	 'kde-l10n-ko'
	 'kde-l10n-lt'
	 'kde-l10n-lv'
##	 'kde-l10n-mai'
##	 'kde-l10n-mk'
##	 'kde-l10n-ml'
	 'kde-l10n-mr'
	 'kde-l10n-nb'
	 'kde-l10n-nds'
	 'kde-l10n-nn'
	 'kde-l10n-nl'
	 'kde-l10n-pa'
	 'kde-l10n-pl'
	 'kde-l10n-pt'
	 'kde-l10n-pt_BR'
	 'kde-l10n-ro'
	 'kde-l10n-ru'
##	 'kde-l10n-si'
	 'kde-l10n-sk'
	 'kde-l10n-sl'
	 'kde-l10n-sr'
	 'kde-l10n-sv'
##	 'kde-l10n-tg'
##	 'kde-l10n-th'
	 'kde-l10n-tr'
	 'kde-l10n-ug'
	 'kde-l10n-uk'
##	 'kde-l10n-vi'
	 'kde-l10n-wa'
	 'kde-l10n-zh_CN'
	 'kde-l10n-zh_TW')


pkg_version=${_kdever}
         
pkg_description="split package"
pkg_upstream_url="http://www.kde.org"
pkg_license=('GPL' 'FDL')
pkg_deps=('ki18n')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'qt5-tools')
                 
pkg_source=(${_mirror}/kde-l10n-ar-${pkg_version}.tar.xz
        ${_mirror}/kde-l10n-ast-${pkg_version}.tar.xz
	${_mirror}/kde-l10n-bg-${pkg_version}.tar.xz
	${_mirror}/kde-l10n-bs-${pkg_version}.tar.xz
	${_mirror}/kde-l10n-ca-${pkg_version}.tar.xz
	${_mirror}/kde-l10n-ca@valencia-${pkg_version}.tar.xz
	${_mirror}/kde-l10n-cs-${pkg_version}.tar.xz
##	${_mirror}/kde-l10n-csb-${pkg_version}.tar.xz
	${_mirror}/kde-l10n-da-${pkg_version}.tar.xz
	${_mirror}/kde-l10n-de-${pkg_version}.tar.xz
	${_mirror}/kde-l10n-el-${pkg_version}.tar.xz
	${_mirror}/kde-l10n-en_GB-${pkg_version}.tar.xz
	${_mirror}/kde-l10n-eo-${pkg_version}.tar.xz
	${_mirror}/kde-l10n-es-${pkg_version}.tar.xz
	${_mirror}/kde-l10n-et-${pkg_version}.tar.xz
	${_mirror}/kde-l10n-eu-${pkg_version}.tar.xz
	${_mirror}/kde-l10n-fa-${pkg_version}.tar.xz
	${_mirror}/kde-l10n-fi-${pkg_version}.tar.xz
	${_mirror}/kde-l10n-fr-${pkg_version}.tar.xz
##	${_mirror}/kde-l10n-fy-${pkg_version}.tar.xz
	${_mirror}/kde-l10n-ga-${pkg_version}.tar.xz
	${_mirror}/kde-l10n-gl-${pkg_version}.tar.xz
##	${_mirror}/kde-l10n-gu-${pkg_version}.tar.xz
	${_mirror}/kde-l10n-he-${pkg_version}.tar.xz
	${_mirror}/kde-l10n-hi-${pkg_version}.tar.xz
	${_mirror}/kde-l10n-hr-${pkg_version}.tar.xz
	${_mirror}/kde-l10n-hu-${pkg_version}.tar.xz
	${_mirror}/kde-l10n-ia-${pkg_version}.tar.xz
	${_mirror}/kde-l10n-id-${pkg_version}.tar.xz
	${_mirror}/kde-l10n-is-${pkg_version}.tar.xz
	${_mirror}/kde-l10n-it-${pkg_version}.tar.xz
	${_mirror}/kde-l10n-ja-${pkg_version}.tar.xz
	${_mirror}/kde-l10n-kk-${pkg_version}.tar.xz
	${_mirror}/kde-l10n-km-${pkg_version}.tar.xz
##	${_mirror}/kde-l10n-kn-${pkg_version}.tar.xz
	${_mirror}/kde-l10n-ko-${pkg_version}.tar.xz
	${_mirror}/kde-l10n-lt-${pkg_version}.tar.xz
	${_mirror}/kde-l10n-lv-${pkg_version}.tar.xz
##	${_mirror}/kde-l10n-mai-${pkg_version}.tar.xz
##	${_mirror}/kde-l10n-mk-${pkg_version}.tar.xz
##	${_mirror}/kde-l10n-ml-${pkg_version}.tar.xz
	${_mirror}/kde-l10n-mr-${pkg_version}.tar.xz
	${_mirror}/kde-l10n-nb-${pkg_version}.tar.xz
	${_mirror}/kde-l10n-nds-${pkg_version}.tar.xz
	${_mirror}/kde-l10n-nl-${pkg_version}.tar.xz
	${_mirror}/kde-l10n-nn-${pkg_version}.tar.xz
	${_mirror}/kde-l10n-pa-${pkg_version}.tar.xz
	${_mirror}/kde-l10n-pl-${pkg_version}.tar.xz
	${_mirror}/kde-l10n-pt-${pkg_version}.tar.xz
	${_mirror}/kde-l10n-pt_BR-${pkg_version}.tar.xz
	${_mirror}/kde-l10n-ro-${pkg_version}.tar.xz
	${_mirror}/kde-l10n-ru-${pkg_version}.tar.xz
##	${_mirror}/kde-l10n-si-${pkg_version}.tar.xz
	${_mirror}/kde-l10n-sk-${pkg_version}.tar.xz
	${_mirror}/kde-l10n-sl-${pkg_version}.tar.xz
	${_mirror}/kde-l10n-sr-${pkg_version}.tar.xz
	${_mirror}/kde-l10n-sv-${pkg_version}.tar.xz
##	${_mirror}/kde-l10n-tg-${pkg_version}.tar.xz
	${_mirror}/kde-l10n-tr-${pkg_version}.tar.xz
	${_mirror}/kde-l10n-ug-${pkg_version}.tar.xz
	${_mirror}/kde-l10n-uk-${pkg_version}.tar.xz
##	${_mirror}/kde-l10n-vi-${pkg_version}.tar.xz
	${_mirror}/kde-l10n-wa-${pkg_version}.tar.xz
	${_mirror}/kde-l10n-zh_CN-${pkg_version}.tar.xz
	${_mirror}/kde-l10n-zh_TW-${pkg_version}.tar.xz)

pkg_shasum=('66fd2ed26bfdfbb45770f0d09df2921c'
         '43138bdd896b3c2832e21ef12c5b5bed'
         '0d3e293c2e439eefa24b2aa09f17b0b2'
         'c24a8aad5ce4d6ae1ca879e79fa441fc'
         '64e3e4ba6be7d546285cd6b769461534'
         '561017974da4ee63cc6d19160e45b10a'
         'b1e9deb5089ccc846ef6d9ebd4a705ac'
         'b660be15ef2630ee9aec6f89a22659d0'
         '25fb0e2d598ac81cfb1cb33bec3968fa'
         '0f6e2f8e4415fefe3530bb9bf292ff41'
         '3326f6dee8b7d99f9dd22e9a9870a699'
         '385484ea72b3c8978bfaab8806e0d393'
         '365445700155a386d1a1b1700635f5e0'
         '676a8e3ed8bdb4de2a8273c13e45c0f2'
         'ee5c26d6987e4164e476518dc56f1a17'
         '7492bf97047da388db5197b095186e11'
         '6a85940832e1f6ba736327d8ad4c806f'
         '48dcd7687853123b322ce0b766a29ade'
         'e8112d1a8fc31854042827a12c7c49ec'
         '506998be7c17c05272e472e520c3dc90'
         '9be7e4d5e08861d98838ad770b81aae4'
         '52245e682469dcc8740c3a248959ed60'
         '46a3179a0543b42cab547de1bed44aad'
         '7f16a1d40c3bd97505ebcf637b262fcf'
         '20aa93bb0d069469dc7f26b9f4e23e32'
         'f5db9a7835767ec989cb3509e6c9e572'
         '8f479f4d5181a7520711fceba91a300d'
         '4243e0c3b8d6eff302922eb288c7324f'
         '4e8f62d97f1fd2ab56244743857b47e1'
         '7a32104647e5e016a52120df5fce0a76'
         '3f703df106ccf29fca78c2817d775f83'
         'f780f7265d14f803b4a30850af0818b6'
         '31b04d9488e1dfe5129ce2f8ac39f965'
         '2302e3c76925c71c8fa7bb24810723ab'
         '48b5b63133487ec9d02eaef41944460e'
         '5fc4354163532f73c08efda8923074a3'
         'c790352b8d4633445181979a82515312'
         '83a376dc91c3e1b10aaa44c0a5103901'
         '8965d66f8f6e42e7bb09d16eada3fb5d'
         '7bc10155df9c654104de3f3b6924726d'
         '41625d2835c81ccbf0adfaea1d990bdf'
         '0f916f774f9f3eaee2fd54679a730905'
         '94e542137acfba8fce9a7671338ff1dd'
         '4d9788b22c6c570a3c1a6ef462b228b0'
         '9a485dfbee109dbd62a78d750f6c738e'
         'eff9ea00b0f0d765db9d4c4831aaa237'
         'c667327aec4fcb7071a5035f88e63d7f'
         '11f0dfb025ed5a1cb585d502186c458e'
         '1f7acbd1ecdd8d62478a39ff7b03abe9'
         'a134580daddc7696146d995814586c7d'
         'b124eec2b84e560395e9277708391fcd'
         'b02c1119a01578b350c937f56773496b'
         '00261a3b96135e05913041c386d4de18'
         '054db764a88ca8092f098ab3a658a24d'
         'cbb20ffc5cbaf534956fde5f609c8f6a')

do_build() {
	cd $CACHE_PATH/

packs=(
       'ar'
       'ast' 
       'bg'
       'bs'
       'ca'
       'ca@valencia'
       'cs'
##       'csb'
       'da'
       'de'
       'el'
       'en_GB'
       'eo'
       'es'
       'et'
       'eu'
       'fa'
       'fi'
       'fr'
##       'fy'
       'ga'
       'gl'
##       'gu'
       'he'
       'hi'
       'hr'
       'hu'
       'ia'
##       'id'
       'is'
       'it'
       'id'
       'ja'
       'kk'
       'km'
##       'kn'
       'ko'
       'lt'
       'lv'
##       'mai'
##       'mk'
##       'ml'
       'mr'
       'nb'
       'nds'
       'nl'
       'nn'
       'pa'
       'pl'
       'pt'
       'pt_BR'
       'ro'
       'ru'
##       'si'
       'sk'
       'sl'
       'sr'
       'sv'
##       'tg'
##       'th'
       'tr'
       'ug'
       'uk'
##       'vi'
       'wa'
       'zh_CN'
       'zh_TW')



 	for it in ${packs[@]} ; do
                pushd "kde-l10n-$it-$pkg_version"
                sed -i 's|add_subdirectory(4)|#add_subdirectory(4)|' ${CACHE_PATH}/kde-l10n-$it-$pkg_version/CMakeLists.txt
                #sed -i 's|add_subdirectory(autocorrect)|#add_subdirectory(autocorrect)|' ${CACHE_PATH}/kde-l10n-pt_BR-$pkg_version/5/pt_BR/data/CMakeLists.txt
                #sed -i 's|add_subdirectory(kdeedu)|#add_subdirectory(kdeedu)|' ${CACHE_PATH}/kde-l10n-$it-$pkg_version/5/$it/messages/CMakeLists.txt
 		cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release
 		make
 		#make DESTDIR=${pkg_prefix} install
 		popd
 	done
}



#
# split-install functions
#
package_kde-l10n-ar()
{
	pkg_description="KDE language support: Arabic"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-ar-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-as()
{
	pkg_description="KDE language support: Assamese"
        groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-as-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-ast()
{
	pkg_description="KDE language support: Asturian"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-ast-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-be()
{
	pkg_description="KDE language support: Belarusian"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-be-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-be@latin()
{
	pkg_description="KDE language support: Belarusian (Latin)"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-be@latin-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-bg()
{
	pkg_description="KDE language support: Bulgarian"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-bg-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-bn-in()
{
	pkg_description="KDE language support: Bengali (India)"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-bn_IN-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}


package_kde-l10n-bn()
{
	pkg_description="KDE language support: Bengali"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-bn-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-bs()
{
	pkg_description="KDE language support: Bosnian"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-bs-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-ca()
{
	pkg_description="KDE language support: Catalan"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-ca-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-ca@valencia()
{
	pkg_description="KDE language support: Valencian (southern Catalan)"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-ca@valencia-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-crh()
{
	pkg_description="KDE language support: Crimean Tatar"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-crh-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-cs()
{
	pkg_description="KDE language support: Czech"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-cs-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-csb()
{
	pkg_description="KDE language support: Kashubian"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-csb-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-cy()
{
	pkg_description="KDE language support: Welsh"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-cy-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-da()
{
	pkg_description="KDE language support: Danish"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-da-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-de()
{
	pkg_description="KDE language support: German"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-de-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-el()
{
	pkg_description="KDE language support: Greek"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-el-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-en_gb()
{
	pkg_description="KDE language support: British English"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-en_GB-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-eo()
{
	pkg_description="KDE language support: Esperanto"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-eo-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-es()
{
	pkg_description="KDE language support: Spanish"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-es-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-et()
{
	pkg_description="KDE language support: Estonian"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-et-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-eu()
{
	pkg_description="KDE language support: Basque"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-eu-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-fa()
{
	pkg_description="KDE language support: Farsi (Persian)"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-fa-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-fi()
{
	pkg_description="KDE language support: Finnish"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-fi-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-fr()
{
	pkg_description="KDE language support: French"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-fr-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-fy()
{
	pkg_description="KDE language support: Frisian"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-fy-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-ga()
{
	pkg_description="KDE language support: Irish Gaelic"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-ga-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-gl()
{
	pkg_description="KDE language support: Galician"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-gl-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-gu()
{
	pkg_description="KDE language support: Gujarati"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-gu-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-ha()
{
	pkg_description="KDE language support: Hausa"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-ha-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-he()
{
	pkg_description="KDE language support: Hebrew"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-he-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-hi()
{
	pkg_description="KDE language support: Hindi"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-hi-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-hne()
{
	pkg_description="KDE language support: Chhattisgarhi"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-hne-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-hr()
{
	pkg_description="KDE language support: Croatian"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-hr-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-hsb()
{
	pkg_description="KDE language support: Upper Sorbian"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-hsb-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-hu()
{
	pkg_description="KDE language support: Hungarian"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-hu-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-hy()
{
	pkg_description="KDE language support: Armenian"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-hy-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-ia()
{
	pkg_description="KDE language support: Interlingua"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-ia-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-id()
{
	pkg_description="KDE language support: Indonesian"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-id-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-is()
{
	pkg_description="KDE language support: Icelandic"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-is-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-it()
{
	pkg_description="KDE language support: Italian"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-it-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-ja()
{
	pkg_description="KDE language support: Japanese"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-ja-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-ka()
{
	pkg_description="KDE language support: Georgian"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-ka-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-kk()
{
	pkg_description="KDE language support: Kazakh"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-kk-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-km()
{
	pkg_description="KDE language support: Khmer"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-km-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-kn()
{
	pkg_description="KDE language support: Kannada"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-kn-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-ko()
{
	pkg_description="KDE language support: Korean"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-ko-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-ku()
{
	pkg_description="KDE language support: Kurdish"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-ku-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-lb()
{
	pkg_description="KDE language support: Luxembourgish"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-lb-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-lt()
{
	pkg_description="KDE language support: Lithuanian"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-lt-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-lv()
{
	pkg_description="KDE language support: Latvian"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-lv-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-mai()
{
	pkg_description="KDE language support: Maithili"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-mai-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-mk()
{
	pkg_description="KDE language support: Macedonian"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-mk-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-ml()
{
	pkg_description="KDE language support: Malayalam"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-ml-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-mr()
{
	pkg_description="KDE language support: Marathi"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-mr-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-ms()
{
	pkg_description="KDE language support: Malay"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-ms-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-nb()
{
	pkg_description="KDE language support: Norwegian Bokmal"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-nb-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-nds()
{
	pkg_description="KDE language support: Low Saxon"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-nds-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-ne()
{
	pkg_description="KDE language support: Nepali"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-ne-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-nl()
{
	pkg_description="KDE language support: Dutch"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-nl-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-nn()
{
	pkg_description="KDE language support: Norwegian Nynorsk"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-nn-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-oc()
{
	pkg_description="KDE language support: Occitan"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-oc-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-or()
{
	pkg_description="KDE language support: Oriya"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-or-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-pa()
{
	pkg_description="KDE language support: Panjabi & Punjabi"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-pa-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-pl()
{
	pkg_description="KDE language support: Polish"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-pl-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-ps()
{
	pkg_description="KDE language support: Pashto"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-ps-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-pt()
{
	pkg_description="KDE language support: Portugese"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-pt-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-pt_BR()
{
	pkg_description="KDE language support: Brazilian Portuguese"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-pt_BR-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-ro()
{
	pkg_description="KDE language support: Romanian"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-ro-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-ru()
{
	pkg_description="KDE language support: Russian"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-ru-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-se()
{
	pkg_description="KDE language support: Northern Sami"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-se-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-si()
{
	pkg_description="KDE language support: Sinhala"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-si-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}


package_kde-l10n-sk()
{
	pkg_description="KDE language support: Slovak"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-sk-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-sl()
{
	pkg_description="KDE language support: Slovenian"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-sl-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-sr()
{
	pkg_description="KDE language support: Serbian"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-sr-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-sr@ijekavian()
{
	pkg_description="KDE language support: Serbian (Ijekavian)"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-sr@ijekavian-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-sr@ijekavianlatin()
{
	pkg_description="KDE language support: Serbian (Ijekavian Latin)"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-sr@ijekavianlatin-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-sr@latin()
{
	pkg_description="KDE language support: Serbian (Latin)"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-sr@latin-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-sv()
{
	pkg_description="KDE language support: Swedish"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-sv-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-ta()
{
	pkg_description="KDE language support: Tamil"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-ta-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-te()
{
	pkg_description="KDE language support: Telugu"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-te-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-tg()
{
	pkg_description="KDE language support: Tajik"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-tg-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}


package_kde-l10n-th()
{
	pkg_description="KDE language support: Thai"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-th-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-tr()
{
	pkg_description="KDE language support: Turkish"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-tr-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-ug()
{
	pkg_description="KDE language support: Uyghur"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-ug-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-uk()
{
	pkg_description="KDE language support: Ukrainian"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-uk-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-uz()
{
	pkg_description="KDE language support: Uzbek"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-uz-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-uz@cyrillic()
{
	pkg_description="KDE language support: Uzbek (Cyrillic)"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-uz@cyrillic-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-vi()
{
	pkg_description="KDE language support: Vietnamese"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-vi-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-wa()
{
	pkg_description="KDE language support: Walloon"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-wa-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-xh()
{
	pkg_description="KDE language support: Xhosa"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-xh-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-zh_CN()
{
	pkg_description="KDE language support: Chinese Simplified"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-zh_CN-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-zh_hk()
{
	pkg_description="KDE language support: Chinese Hong Kong"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-zh_HK-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}

package_kde-l10n-zh_TW()
{
	pkg_description="KDE language support: Chinese Traditional"
	groups=('kde-uninstall' 'kde-l10n' 'localization')


	pushd ${CACHE_PATH}/kde-l10n-zh_TW-${pkg_version}
		make DESTDIR=${pkg_prefix} install
	popd
}


