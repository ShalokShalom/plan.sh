pkg_origin=

pkg_name=gpsd
pkg_version=3.16
pkg_description="GPS daemon and library to support USB/serial GPS devices"
pkg_upstream_url="http://catb.org/gpsd/"
pkg_license=('BSD')
pkg_deps=('python2' 'libusb' 'bluez' 'desktop-file-utils') # 'qt5-base')
optpkg_deps=('php: generate a PHP status page for your GPS')
pkg_build_deps=('scons' 'docbook-xsl' 'asciidoc')
backup=('etc/gpsd.conf')
pkg_source=("http://download.savannah.gnu.org/releases/gpsd/${pkg_name}-${pkg_version}.tar.gz"
        'gpsd.conf')
pkg_shasum=('68691b5de4c94f82ec4062b042b5eb63'
         '3e963df3f9f7ef3572ecc648ae829315')

do_build() {
  cd ${pkg_name}-${pkg_version}
  #sed -i 's|QtNetwork|Qt5Network|' "${CACHE_PATH}/${pkg_name}-${pkg_version}/SConstruct"

  scons prefix=/usr \
    systemd=yes \
    libQgpsmm=no \
    gpsd_group=uucp 
  scons build
}

do_package() {
  cd ${pkg_name}-${pkg_version}

  sed -i 's|.so gps.1|.so man1/gps.1|' cgps.1 lcdgps.1 xgps.1 xgpsspeed.1

  export DESTDIR=${pkg_prefix}
  scons install

  install -D -m644 gpsd.rules ${pkg_prefix}/usr/lib/udev/rules.d/25-gpsd-usb.rules
  install -D -m644 ${CACHE_PATH}/gpsd.conf ${pkg_prefix}/etc/gpsd.conf

  sed -i 's|/etc/default/gpsd|/etc/conf.d/gpsd|' gpsd.hotplug
  install -D -m755 gpsd.hotplug ${pkg_prefix}/usr/lib/udev/gpsd.hotplug

  #install -D -m644 packaging/X11/xgps.desktop "${pkg_prefix}/usr/share/applications/xgps.desktop"
  #install -D -m644 packaging/X11/xgpsspeed.desktop "${pkg_prefix}/usr/share/applications/xgpsspeed.desktop"
  #install -D -m644 packaging/X11/gpsd-logo.png "${pkg_prefix}/usr/share/gpsd/gpsd-logo.png"

  install -D -m644 systemd/gpsd.service ${pkg_prefix}/usr/lib/systemd/system/gpsd.service
  install -D -m644 systemd/gpsd.socket ${pkg_prefix}/usr/lib/systemd/system/gpsd.socket

  install -D -m644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
