pkg_origin=cosmos

pkg_name=tp_smapi
pkg_version=0.42
_extramodules=/lib/modules/extramodules-4.11
pkg_description="Modules for ThinkPad's SMAPI functionality"
pkg_upstream_url='https://github.com/evgeni/tp_smapi'
pkg_license=('GPL')
pkg_deps=('linux>=4.11' 'linux<4.12')
pkg_build_deps=('linux-headers')
install="${pkg_name}.install"
pkg_source=("https://github.com/evgeni/tp_smapi/releases/download/tp-smapi%2F${pkg_version}/${pkg_name}-${pkg_version}.tgz")
pkg_shasum=('9796e92c86a53dd84823ca503a69c49e')

do_build() {

 _kernver=$(< "${_extramodules}/version")

  sed -ri -e "s/^(KVER\s*:=).*$/\1 ${_kernver}/" \
	  -e "s#^(KBASE\s*:=).*\$#\1 ${_extramodules%/*}/${_kernver}#" Makefile

  make HDAPS=1
}

do_package() {
  _kernver=$(< "${_extramodules}/version")

  make -C "${_extramodules%/*}/${_kernver}/build" \
    INSTALL_MOD_PATH="${CACHE_PATH}/${_extramodules%%/lib/*}" \
    M="${CACHE_PATH}/${pkg_name}-${pkg_version}" modules_install

  mv "${_kernver}/extra" "${_extramodules##*/}"
  rmdir "${_kernver}"

  # compress kernel modules
  find "${CACHE_PATH}" -name "*.ko" -exec gzip -9 {} +

  # load module on startup
  echo tp_smapi > "${CACHE_PATH}/${pkg_name}.conf"
  install -Dm644 "${CACHE_PATH}/${pkg_name}.conf" "${CACHE_PATH}/lib/modules-load.d/${pkg_name}.conf"

  # update kernel version in install file
  sed -ri "s#^(extramodules=).*\$#\1${_extramodules}#" "${startdir}/${pkg_name}.install"
}
