pkg_origin=cosmos

# Find the kernel name inside the chroot
_extramodules=extramodules-4.11
_kver="$(cat /lib/modules/${_extramodules}/version)"

pkg_name=broadcom-wl
pkg_version=6.30.223.271
_pkg_version=6_30_223_271
pkg_description='Broadcom 802.11abgn hybrid Linux networking device driver'
pkg_upstream_url='https://www.broadcom.com/support/802.11/'
pkg_license=('custom')
pkg_deps=('linux>=4.11' 'linux<4.12')
pkg_build_deps=('linux-headers')

pkg_source=("https://docs.broadcom.com/docs-and-downloads/docs/linux_sta/hybrid-v35_64-nodebug-pcoem-${_pkg_version}.tar.gz"
        'modprobe.d'
        'license.patch'
        'linux-recent.patch')
pkg_shasum=('115903050c41d466161784d4c843f4f9'
         '3600df7db49c759c655bc6a7789b28d4'
         '52f9dcef8112f8e325d9236e5290cb88'
         '6889fbc4b8f851908f2f0f94413b599e')

backup=('etc/modprobe.d/broadcom-wl.conf')
install=install

do_build() {

	patch -p1 -i license.patch
	patch -p1 -i linux-recent.patch
	
	sed -i 's|BRCM_WLAN_IFNAME eth|BRCM_WLAN_IFNAME wlan|' src/wl/sys/wl_linux.c

	make -C /lib/modules/"${_kver}"/build M=`pwd`
}

do_package() {

	install -D -m 755 wl.ko "${pkg_prefix}/lib/modules/${_extramodules}/wl.ko"
	gzip "${pkg_prefix}/lib/modules/${_extramodules}/wl.ko"

	install -D -m 644 lib/LICENSE.txt "${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE"
	install -D -m 644 modprobe.d "${pkg_prefix}"/etc/modprobe.d/broadcom-wl.conf
}
