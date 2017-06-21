pkg_origin=cosmos

pkg_name=lirc-utils
pkg_version=0.9.0
pkg_description="Linux Infrared Remote Control utils"
pkg_upstream_url="http://www.lirc.org/"
pkg_license=('GPL')
_kernver='3.12.4-1'
_extramodules='extramodules-3.12'
pkg_deps=('alsa-lib' 'libx11' 'libftdi' 'linux')
pkg_build_deps=('help2man' 'linux-headers' 'python2')
pkg_deps=('python2: pronto2lirc utility')
install=lirc-utils.install
pkg_source=("http://sourceforge.net/projects/lirc/files/LIRC/$pkg_version/lirc-$pkg_version.tar.bz2"
        'lirc_wpc8769l.patch'
        'lircd-handle-large-config.patch'
        'lirc_atiusb-kfifo.patch'
        'kernel-2.6.39.patch'
        'linux-3.8.patch'
        'lirc.logrotate' 
	'lirc.service' 'lircm.service' 'irexec.service' 'lirc.tmpfiles')
pkg_shasum=('b232aef26f23fe33ea8305d276637086'
         '1cce37e18e3f6f46044abab29016d18f'
         '1014f2ea03a557c673c9084118676111'
         '86e6894acde723ebc8a2284512283f17'
         '087a7d102e1c96bf1179f38db2b0b237'
         '5528b4939b741519a551c336add55780'
         '3deb02604b37811d41816e9b4385fcc3'
         'dab8a73bcc5fd5479d8750493d8d97dc'
         'c2e20fe68b034df752dba2773db16ebe'
         '07131d117fcfe9dcd50c453c3a5e9531'
         'febf25c154a7d36f01159e84f26c2d9a')

do_build() {
        # configure
        patch -p1 -i "${CACHE_PATH}"/lirc_wpc8769l.patch
        patch -p1 -i "${CACHE_PATH}"/lircd-handle-large-config.patch
        patch -p1 -i "${CACHE_PATH}"/lirc_atiusb-kfifo.patch
        patch -p1 -i "${CACHE_PATH}"/kernel-2.6.39.patch
        patch -p1 -i "${CACHE_PATH}"/linux-3.8.patch

        sed -i 's/AM_CONFIG_HEADER/AC_CONFIG_HEADER/' configure.ac

	autoreconf 
	libtoolize 

	./configure --enable-sandboxed --prefix=/usr \
	--with-driver=all --with-kerneldir=/usr/src/linux-${_kernver} \
	--with-moduledir=/lib/modules/${_kernver}/kernel/drivers/misc \
	--with-transmitter
		
        # Remove drivers already in kernel
        sed -e "s:lirc_dev::" -e "s:lirc_bt829::" -e "s:lirc_igorplugusb::" \
            -e "s:lirc_imon::" -e "s:lirc_parallel::" -e "s:lirc_sasem::" \
            -e "s:lirc_serial::" -e "s:lirc_sir::" -e "s:lirc_ttusbir::" \
            -e "s:lirc_atiusb::" -e "s:lirc_i2c::" \
            -i Makefile drivers/Makefile drivers/*/Makefile tools/Makefile 
	make 
}

do_package() {
	make DESTDIR=""${pkg_prefix}"" install 
	
        install -D -m644 "${CACHE_PATH}"/lirc.service "${pkg_prefix}"/usr/lib/systemd/system/lirc.service
	install -D -m644 "${CACHE_PATH}"/lircm.service "${pkg_prefix}"/usr/lib/systemd/system/lircm.service
	install -D -m644 "${CACHE_PATH}"/irexec.service "${pkg_prefix}"/usr/lib/systemd/system/irexec.service
	install -D -m644 "${CACHE_PATH}"/lirc.tmpfiles "${pkg_prefix}"/usr/lib/tmpfiles.d/lirc.conf
		
	cp -rp remotes "${pkg_prefix}"/usr/share/lirc 
	chmod -R go-w "${pkg_prefix}"/usr/share/lirc/ 

	# install the logrotate config
    	install -D -m644 "${CACHE_PATH}"/lirc.logrotate "${pkg_prefix}"/etc/logrotate.d/lirc 

	install -d -m755 "${pkg_prefix}"/etc/lirc 
	
        make DESTDIR="${pkg_prefix}" moduledir="/usr/lib/modules/${_extramodules}" install

        # set the kernel for inside the install script
        sed -i -e "s/EXTRAMODULES=.*/EXTRAMODULES=${_extramodules}/g" "${startdir}/lirc-utils.install"
        find "${pkg_prefix}" -name '*.ko' -exec gzip -9 {} \;
}
