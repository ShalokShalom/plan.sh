pkg_origin=cosmos

pkg_name=crda
pkg_version=3.18
pkg_description="Central Regulatory Domain Agent"
pkg_upstream_url="http://wireless.kernel.org/en/developers/Regulatory/CRDA"
pkg_license=('custom')
pkg_deps=('wireless-regdb' 'libnl' 'libgcrypt' 'systemd' 'iw')
pkg_build_deps=('python2-m2crypto')
install=crda.install
pkg_source=("https://kernel.org/pub/software/network/crda/${pkg_name}-${pkg_version}.tar.xz"
        'set-wireless-regdom'
        'libreg.patch')
pkg_shasum=('0431fef3067bf503dfb464069f06163a'
         '65c93f2ff2eb1b29d9e9fa102ae2dd45'
         '067be591ddedb9572a73373c92fb4bc7')

do_build() {
  cd "${CACHE_PATH}"/${pkg_name}-${pkg_version}
  sed -e "s|$(Q)ldconfig||" -i ${CACHE_PATH}/${pkg_name}-${pkg_version}/Makefile
  patch -p1 -i "${CACHE_PATH}"/libreg.patch
  
  make
}

do_package() {
  cd "${CACHE_PATH}"/${pkg_name}-${pkg_version}

  make DESTDIR="${pkg_prefix}" UDEV_RULE_DIR=/usr/lib/udev/rules.d/ SBINDIR=/usr/bin/ install
 
  echo 'ACTION=="add" SUBSYSTEM=="module", DEVPATH=="/module/cfg80211", RUN+="/usr/bin/set-wireless-regdom"' >> "${pkg_prefix}"/usr/lib/udev/rules.d/85-regulatory.rules

  install -D -m644 "${CACHE_PATH}"/${pkg_name}-${pkg_version}/LICENSE "${pkg_prefix}"/usr/share/licenses/crda/LICENSE
  install -D -m755 "${CACHE_PATH}"/set-wireless-regdom "${pkg_prefix}"/usr/bin/set-wireless-regdom
}

