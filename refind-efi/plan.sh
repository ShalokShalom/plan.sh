pkg_origin=cosmos

_USE_GNU_EFI="1"

pkg_name=refind-efi
pkg_version=0.10.8
pkg_description="Rod Smith's fork of rEFIt UEFI Boot Manager"
pkg_upstream_url="http://www.rodsbooks.com/refind/index.html"
pkg_license=('GPL3' 'custom')
pkg_deps=('bash' 'dosfstools' 'efibootmgr')
optpkg_deps=('imagemagick: For refind-mkfont script')
install="${pkg_name}.install"
pkg_source=("https://downloads.sourceforge.net/refind/refind-src-${pkg_version}.tar.gz"
        'refind_linux.conf')
pkg_shasum=('fbca81d182591fbb87bbb60506ba2636'
         '12ce3e22a216e7b25c253478a34713b4')


if [[ "${_USE_GNU_EFI}" == "1" ]]; then
	
	pkg_description="${pkgdesc} - Built with GNU-EFI libs"
	pkg_build_deps=('gnu-efi-libs')
	
else
	
	pkg_description="${pkgdesc} - Built with Tianocore UDK libs"
	makedepends+=('subversion' 'python2')
	
	_TIANOCORE_SVN_pkg_upstream_url="https://svn.code.sf.net/p/edk2/code/branches/UDK2014"
	_TIANO_DIR_="tianocore-udk-2014-svn"
	_TIANO_SVN_REV_="15322"
	
	_TIANOCORE_PKG="Mde"
	_TIANOCORE_TARGET="RELEASE"
	_UDK_TARGET="${_TIANOCORE_PKG}Pkg/${_TIANOCORE_PKG}Pkg.dsc"
	_COMPILER="GCC48"
	
	## BaseTools MdePkg MdeModulePkg IntelFrameworkPkg IntelFrameworkModulePkg
	for _DIR_ in BaseTools MdePkg MdeModulePkg IntelFrameworkPkg IntelFrameworkModulePkg ; do
		source+=("${_TIANO_DIR_}_${_DIR_}::svn+${_TIANOCORE_SVN_URL}/${_DIR_}#revision=${_TIANO_SVN_REV_}")
	done
	
fi


_setup_tianocore_env_vars() {
	
	msg "Setup UDK PATH ENV variables"
	export _UDK_DIR="${CACHE_PATH}/${_TIANO_DIR_}_build"
	export EDK_TOOLS_PATH="${_UDK_DIR}/BaseTools"
	
}

_prepare_tianocore_sources() {
	
	msg "Delete old UDK BUILD dir"
	rm -rf "${_UDK_DIR}/" || true
	
	msg "Create UDK BUILD dir"
	mkdir -p "${_UDK_DIR}/"
	
	for _DIR_ in BaseTools MdePkg MdeModulePkg IntelFrameworkPkg IntelFrameworkModulePkg ; do
		mv "${CACHE_PATH}/${_TIANO_DIR_}_${_DIR_}" "${_UDK_DIR}/${_DIR_}"
	done
	
	
	msg "Cleanup UDK config files"
	rm -rf "${_UDK_DIR}/Build/" || true
	rm -rf "${_UDK_DIR}/Conf/" || true
	mkdir -p "${_UDK_DIR}/Conf/"
	mkdir -p "${_UDK_DIR}/Build/"
	
	msg "Use python2 for UDK BaseTools"
	sed 's|python |python2 |g' -i "${EDK_TOOLS_PATH}/BinWrappers/PosixLike"/* || true
	sed 's|python |python2 |g' -i "${EDK_TOOLS_PATH}/Tests/GNUmakefile"
	
	msg "Fix GCC Warning as error"
	sed 's|-Werror |-Wno-error -Wno-unused-but-set-variable |g' -i "${EDK_TOOLS_PATH}/Source/C/Makefiles/header.makefile" || true
	sed 's|-Werror |-Wno-error -Wno-unused-but-set-variable |g' -i "${EDK_TOOLS_PATH}/Conf/tools_def.template" || true
	
	msg "Fix GenFw: ERROR 3000: Invalid, bad symbol definition"
	## http://www.mail-archive.com/edk2-devel@lists.sourceforge.net/msg03625.html
	sed -e 's|_OBJCOPY_FLAGS      =|_OBJCOPY_FLAGS      = -R .eh_frame|g' -i "${EDK_TOOLS_PATH}/Conf/tools_def.template" || true
	
	msg "Fix GCC >=4.7 error - gcc: error: unrecognized command line option '-melf_x86_64'"
	sed 's| -m64 --64 -melf_x86_64| -m64|g' -i "${EDK_TOOLS_PATH}/Conf/tools_def.template" || true
	sed 's|--64 | |g' -i "${EDK_TOOLS_PATH}/Conf/tools_def.template" || true
	sed 's| -m64 -melf_x86_64| -m64|g' -i "${EDK_TOOLS_PATH}/Conf/tools_def.template" || true
	
	msg "Remove GCC -g debug option and add -O0 -mabi=ms -maccumulate-outgoing-args"
	sed 's|DEFINE GCC_ALL_CC_FLAGS            = -g |DEFINE GCC_ALL_CC_FLAGS            = -O0 -mabi=ms -maccumulate-outgoing-args |g' -i "${EDK_TOOLS_PATH}/Conf/tools_def.template" || true
	sed 's|DEFINE GCC44_ALL_CC_FLAGS            = -g |DEFINE GCC44_ALL_CC_FLAGS            = -O0 -mabi=ms -maccumulate-outgoing-args |g' -i "${EDK_TOOLS_PATH}/Conf/tools_def.template" || true
	
	# msg "Fix GenFw: ERROR 3000: Invalid, Unsupported section alignment"
	sed 's|--gc-sections|--gc-sections --build-id=none|g' -i "${EDK_TOOLS_PATH}/Conf/tools_def.template"
	
	msg "Fix UDK Target Platform"
	sed "s|ACTIVE_PLATFORM       = Nt32Pkg/Nt32Pkg.dsc|ACTIVE_PLATFORM       = ${_UDK_TARGET}|g" -i "${EDK_TOOLS_PATH}/Conf/target.template" || true
	sed "s|TARGET                = DEBUG|TARGET                = ${_TIANOCORE_TARGET}|g" -i "${EDK_TOOLS_PATH}/Conf/target.template" || true
	sed "s|TOOL_CHAIN_TAG        = MYTOOLS|TOOL_CHAIN_TAG        = ${_COMPILER}|g" -i "${EDK_TOOLS_PATH}/Conf/target.template" || true
	
	msg "Fix UDK Target ARCH for rEFInd"
	#sed "s|X64|${_TIANO_ARCH}|g" -i "${EDK_TOOLS_PATH}/Conf/target.template" || true
	#sed "s|IA32|X64|g" -i "${EDK_TOOLS_PATH}/Conf/target.template" || true
	
	chmod 0755 "${_UDK_DIR}/BaseTools/BuildEnv"
	
}

_prepare_refind_sources() {
	
	
	if [[ "${_USE_GNU_EFI}" == "1" ]]; then
		msg "Enable GNU_EFI_USE_MS_ABI"
		sed "s|-DEFI_FUNCTION_WRAPPER|-DEFI_FUNCTION_WRAPPER -maccumulate-outgoing-args|g" -i "${CACHE_PATH}/refind-${pkg_version}/Make.common" || true
		sed "s|-DEFIX64|-DEFIX64 -maccumulate-outgoing-args|g" -i "${CACHE_PATH}/refind-${pkg_version}/Make.common" || true
		sed "s|-m64|-maccumulate-outgoing-args -m64|g" -i "${CACHE_PATH}/refind-${pkg_version}/filesystems/Make.gnuefi" || true
	else
		msg "Fix UDK Path in rEFInd Makefiles"
		sed "s|EDK2BASE = /usr/local/UDK2014/MyWorkSpace|EDK2BASE = ${_UDK_DIR}|g" -i "${CACHE_PATH}/refind-${pkg_version}/Make.tiano" || true
		sed "s|EDK2BASE = /usr/local/UDK2014/MyWorkSpace|EDK2BASE = ${_UDK_DIR}|g" -i "${CACHE_PATH}/refind-${pkg_version}/refind/Make.tiano" || true
		sed "s|EDK2BASE = /usr/local/UDK2014/MyWorkSpace|EDK2BASE = ${_UDK_DIR}|g" -i "${CACHE_PATH}/refind-${pkg_version}/filesystems/Make.tiano" || true
		sed "s|EDK2BASE = /usr/local/UDK2014/MyWorkSpace|EDK2BASE = ${_UDK_DIR}|g" -i "${CACHE_PATH}/refind-${pkg_version}/gptsync/Make.tiano" || true
		sed "s|EDK2BASE = /usr/local/UDK2010/MyWorkSpace|EDK2BASE = ${_UDK_DIR}|g" -i "${CACHE_PATH}/refind-${pkg_version}/Make.tiano" || true
		sed "s|EDK2BASE = /usr/local/UDK2010/MyWorkSpace|EDK2BASE = ${_UDK_DIR}|g" -i "${CACHE_PATH}/refind-${pkg_version}/refind/Make.tiano" || true
		sed "s|EDK2BASE = /usr/local/UDK2010/MyWorkSpace|EDK2BASE = ${_UDK_DIR}|g" -i "${CACHE_PATH}/refind-${pkg_version}/filesystems/Make.tiano" || true
		sed "s|EDK2BASE = /usr/local/UDK2010/MyWorkSpace|EDK2BASE = ${_UDK_DIR}|g" -i "${CACHE_PATH}/refind-${pkg_version}/gptsync/Make.tiano" || true
		
		msg "Fix GenFw: ERROR 3000: Invalid, refind_x64.dll bad symbol definition"
		sed -e 's|--strip-unneeded|--strip-unneeded -R .eh_frame|g' -i "${CACHE_PATH}/refind-${pkg_version}/Make.tiano" || true
		sed -e 's|--strip-unneeded|--strip-unneeded -R .eh_frame|g' -i "${CACHE_PATH}/refind-${pkg_version}/refind/Make.tiano" || true
		sed -e 's|--strip-unneeded|--strip-unneeded -R .eh_frame|g' -i "${CACHE_PATH}/refind-${pkg_version}/filesystems/Make.tiano"
		sed -e 's|--strip-unneeded|--strip-unneeded -R .eh_frame|g' -i "${CACHE_PATH}/refind-${pkg_version}/gptsync/Make.tiano" || true
	
		# msg "Fix GenFw: ERROR 3000: Invalid section alignment"
		sed 's|--gc-sections|--gc-sections --build-id=none|g' -i "${CACHE_PATH}/refind-${pkg_version}/Make.tiano" || true
		sed 's|--gc-sections|--gc-sections --build-id=none|g' -i "${CACHE_PATH}/refind-${pkg_version}/refind/Make.tiano" || true
		sed 's|--gc-sections|--gc-sections --build-id=none|g' -i "${CACHE_PATH}/refind-${pkg_version}/filesystems/Make.tiano" || true
		sed 's|--gc-sections|--gc-sections --build-id=none|g' -i "${CACHE_PATH}/refind-${pkg_version}/gptsync/Make.tiano" || true
	fi
	
}

do_prepare() {
	
	if [[ "${_USE_GNU_EFI}" != "1" ]]; then
		_setup_tianocore_env_vars
		
		msg "Prepare Tianocore Sources"
		_prepare_tianocore_sources
	fi
	
	msg "Prepare rEFInd Sources"
	_prepare_refind_sources
	
}

_build_tianocore_sources() {
	
	_setup_tianocore_env_vars
	
	
	msg "Unset all compiler FLAGS"
	unset CFLAGS
	unset CPPFLAGS
	unset CXXFLAGS
	unset LDFLAGS
	unset MAKEFLAGS
	
	msg "Setup UDK Environment"
	source "${_UDK_DIR}/BaseTools/BuildEnv" BaseTools
	echo
	
	msg "Compile UDK BaseTools"
	make -C "${EDK_TOOLS_PATH}"
	echo
	
	msg "Unset all compiler FLAGS"
	unset CFLAGS
	unset CPPFLAGS
	unset CXXFLAGS
	unset LDFLAGS
	unset MAKEFLAGS
	
	msg "Compile UDK Libraries"
	"${EDK_TOOLS_PATH}/BinWrappers/PosixLike/build" -p "${_UDK_TARGET}" -a X64 -b "${_TIANOCORE_TARGET}" -t "${_COMPILER}"
	echo
	
}

do_build() {
	
	if [[ "${_USE_GNU_EFI}" != "1" ]]; then
		_build_tianocore_sources
	fi
	
	
	msg "Unset all compiler FLAGS"
	unset CFLAGS
	unset CPPFLAGS
	unset CXXFLAGS
	unset LDFLAGS
	unset MAKEFLAGS
	
	msg "Compile rEFInd UEFI application"
	if [[ "${_USE_GNU_EFI}" == "1" ]]; then
		make gnuefi
		echo
	else
		make tiano
		echo
	fi
	
	
	msg "Unset all compiler FLAGS"
	unset CFLAGS
	unset CPPFLAGS
	unset CXXFLAGS
	unset LDFLAGS
	unset MAKEFLAGS
	
	msg "Compile UEFI FS drivers"
	if [[ "${_USE_GNU_EFI}" == "1" ]]; then
		make fs_gnuefi
		echo
	else
		make fs
		echo
	fi
	
}

do_package() {
	
	msg "Install the rEFInd UEFI application"
	install -d "${CACHE_PATH}/usr/share/refind/"
	install -D -m0644 "${CACHE_PATH}/refind-${pkg_version}/refind/refind_x64.efi" "${CACHE_PATH}/usr/share/refind/refind_x64.efi"
	
	msg "Install UEFI drivers built from rEFInd"
	install -d "${CACHE_PATH}/usr/share/refind/drivers_x64/"
	install -D -m0644 "${CACHE_PATH}/refind-${pkg_version}/drivers_x64"/*.efi "${CACHE_PATH}/usr/share/refind/drivers_x64/"
	
	msg "Install UEFI applications built from rEFInd"
	install -d "${CACHE_PATH}/usr/share/refind/tools_x64"
	install -D -m0644 "${CACHE_PATH}/refind-${pkg_version}/gptsync/gptsync_x64.efi" "${CACHE_PATH}/usr/share/refind/tools_x64/gptsync_x64.efi"
	
	msg "Install rEFInd helper scripts"
	install -d "${CACHE_PATH}/usr/bin/"
	install -D -m0755 "${CACHE_PATH}/refind-${pkg_version}/refind-install" "${CACHE_PATH}/usr/bin/refind-install"
	install -D -m0755 "${CACHE_PATH}/refind-${pkg_version}/mkrlconf" "${CACHE_PATH}/usr/bin/refind-mkrlconf"
	install -D -m0755 "${CACHE_PATH}/refind-${pkg_version}/mvrefind" "${CACHE_PATH}/usr/bin/refind-mvrefind"
	install -D -m0755 "${CACHE_PATH}/refind-${pkg_version}/fonts/mkfont.sh" "${CACHE_PATH}/usr/bin/refind-mkfont"
	
	msg "Install the rEFInd sample config files"
	install -D -m0644 "${CACHE_PATH}/refind-${pkg_version}/refind.conf-sample" "${CACHE_PATH}/usr/share/refind/refind.conf-sample"
	install -D -m0644 "${CACHE_PATH}/refind_linux.conf" "${CACHE_PATH}/usr/share/refind/refind_linux.conf-sample"
	
	msg "Install the rEFInd docs"
	install -d "${CACHE_PATH}/usr/share/refind/docs/html/"
	install -d "${CACHE_PATH}/usr/share/refind/docs/Styles/"
	install -D -m0644 "${CACHE_PATH}/refind-${pkg_version}/docs/refind"/* "${CACHE_PATH}/usr/share/refind/docs/html/"
	install -D -m0644 "${CACHE_PATH}/refind-${pkg_version}/docs/Styles"/* "${CACHE_PATH}/usr/share/refind/docs/Styles/"
	install -D -m0644 "${CACHE_PATH}/refind-${pkg_version}/README.txt" "${CACHE_PATH}/usr/share/refind/docs/README.txt"
	install -D -m0644 "${CACHE_PATH}/refind-${pkg_version}/NEWS.txt" "${CACHE_PATH}/usr/share/refind/docs/NEWS.txt"
	rm -f "${CACHE_PATH}/usr/share/refind/docs/html/.DS_Store" || true
	
	msg "Install the rEFInd fonts"
	install -d "${CACHE_PATH}/usr/share/refind/fonts/"
	install -D -m0644 "${CACHE_PATH}/refind-${pkg_version}/fonts"/* "${CACHE_PATH}/usr/share/refind/fonts/"
	rm -f "${CACHE_PATH}/usr/share/refind/fonts/mkfont.sh"
	
	msg "Install the rEFInd icons"
	install -d "${CACHE_PATH}/usr/share/refind/icons/"
	install -D -m0644 "${CACHE_PATH}/refind-${pkg_version}/icons"/*.png "${CACHE_PATH}/usr/share/refind/icons/"
	
	msg "Install the rEFInd images"
	install -d "${CACHE_PATH}/usr/share/refind/images/"
	install -D -m0644 "${CACHE_PATH}/refind-${pkg_version}/images"/*.{png,bmp} "${CACHE_PATH}/usr/share/refind/images/"
	
	msg "Install the rEFInd keys"
	install -d "${CACHE_PATH}/usr/share/refind/keys/"
	install -D -m0644 "${CACHE_PATH}/refind-${pkg_version}/keys"/* "${CACHE_PATH}/usr/share/refind/keys/"
	
	msg "Install the rEFIt license file, since rEFInd is a fork of rEFIt"
	install -d "${CACHE_PATH}/usr/share/licenses/refind/"
	install -D -m0644 "${CACHE_PATH}/refind-${pkg_version}/LICENSE.txt" "${CACHE_PATH}/usr/share/licenses/refind/LICENSE"
	
	msg "Use '#!/usr/bin/env bash' in all scripts"
	sed 's|#!/bin/bash|#!/usr/bin/env bash|g' -i "${CACHE_PATH}/usr/bin"/refind-* || true
	
	msg "Point refind dir paths to /usr/share/refind/ in refind-install script"
	sed 's|^ThisDir=.*|ThisDir="/usr/share/refind/"|g' -i "${CACHE_PATH}/usr/bin/refind-install"
	sed 's|^RefindDir=.*|RefindDir="/usr/share/refind/"|g' -i "${CACHE_PATH}/usr/bin/refind-install"
	sed 's|^ThisScript=.*|ThisScript="/usr/bin/refind-install"|g' -i "${CACHE_PATH}/usr/bin/refind-install"
	
}
