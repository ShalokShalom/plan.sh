pkg_origin=cosmos

pkg_name=usbmuxd
pkg_version=1.1.0
pkg_description="A USB multiplexing daemon."
pkg_upstream_url="http://libimobiledevice.org/"
pkg_license=('GPL2' 'GPL3')
pkg_deps=('libimobiledevice')
install='usbmuxd.install'
pkg_source=("http://cgit.sukimashita.com/usbmuxd.git/snapshot/usbmuxd-${pkg_version}.tar.bz2"
        'usbmuxd.service'
        '39-usbmuxd.rules')
pkg_shasum=('ffda2df9688384f780931b5c3ad183c2'
         'c846093c80108262d2fa442ee47433bf'
         'dc4b2893651149eccbf7b2c8467cd288')

do_build() {
    sed -i -e 's|udevrulesdir = /lib/udev/rules.d|udevrulesdir = /usr/lib/udev/rules.d|' Makefile.am

    NOCONFIGURE=1 ./autogen.sh
    ./configure --prefix=/usr --sbindir=/usr/bin
    make
}

do_package() {
    make DESTDIR=${CACHE_PATH} install  
	
    install -D -m644 ${CACHE_PATH}/usbmuxd.service ${CACHE_PATH}/usr/lib/systemd/system/usbmuxd.service
    install -m644 ${CACHE_PATH}/39-usbmuxd.rules ${CACHE_PATH}/usr/lib/udev/rules.d/
}
