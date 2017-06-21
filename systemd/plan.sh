pkg_origin=cosmos

pkg_name=systemd
pkg_version=233
epoch=1
pkg_description="System and Session Manager"
pkg_upstream_url="http://www.freedesktop.org/wiki/Software/systemd"
pkg_license=('GPL2' 'LGPL2.1')
pkg_deps=('acl' 'bash' 'glibc' 'kmod' 'hwids' 'util-linux' 'kbd' 'libcap' 'libxslt' 'iptables'
         'linux-api-headers' 'pam' 'xz' 'libgcrypt' 'dbus' 'libidn' 'lz4' 'python2-systemd' 'quota' 'libseccomp') # 'audit') 
pkg_build_deps=('docbook-xsl' 'gperf' 'intltool' 'cryptsetup' 'libmicrohttpd' 'gnu-efi-libs')
optpkg_deps=('cryptsetup: required for encrypted block devices'
            'libmicrohttpd: systemd-journal-gatewayd')
backup=(etc/dbus-1/system.d/org.freedesktop.systemd1.conf
        etc/dbus-1/system.d/org.freedesktop.hostname1.conf
        etc/dbus-1/system.d/org.freedesktop.login1.conf
        etc/dbus-1/system.d/org.freedesktop.locale1.conf
        etc/dbus-1/system.d/org.freedesktop.machine1.conf
        etc/dbus-1/system.d/org.freedesktop.timedate1.conf
        etc/systemd/bootchart.conf
        etc/systemd/system.conf
        etc/systemd/user.conf
        etc/systemd/logind.conf
        etc/systemd/journald.conf
        etc/udev/udev.conf)
install="systemd.install"
pkg_source=("https://github.com/systemd/systemd/archive/v${pkg_version}.tar.gz"
        'initcpio-hook-udev'
        'initcpio-install-systemd'
        'initcpio-install-udev'
        'loader.conf'
        'KaOS.conf'
        'KaOS_fallback.conf'
        'splash.bmp'
        'systemd-tmpfiles.hook'
        "https://github.com/systemd/systemd/commit/ab883125704b9310dcdfcf7451a27e85609da76c.diff")
pkg_shasum=('11d3ff48f3361b8bdcfcdc076a31b537'
         'b2da235893d76ed6b810fa5e8d2afe67'
         'f422035c2a36b4fa51f4a369eccc01f4'
         'bde43090d4ac0ef048e3eaee8202a407'
         '30b74b38eaf1178bbc540bda9a24bfe2'
         'eb444ae327472b98a65631ede777720a'
         'b8d8ebeab17edbe91209e705cfc9e774'
         'd7eec59a2aaa54770d22ccfa52d0ac2b'
         '7d5910d12fdfce56228a1aac8c3d618c'
         'bf8f599cd5658a3e3614ae6509292eaa')

do_build() {
  cd ${pkg_name}-${pkg_version}
  #rm src/journal/audit_type-to-name.h
  #rm src/udev/keyboard-keys-from-name.gperf
  
  sed -i 's|Linux Boot Manager|Systemd Boot Manager|' src/boot/bootctl.c
  # destroy should not be an option....
  patch -p1 -i ${CACHE_PATH}/ab883125704b9310dcdfcf7451a27e85609da76c.diff
  
  NTP_SERVERS="0.north-america.pool.ntp.org 1.north-america.pool.ntp.org 2.north-america.pool.ntp.org 3.north-america.pool.ntp.org"
  
  ./autogen.sh
  ./configure \
      --libexecdir=/usr/lib \
      --localstatedir=/var \
      --sysconfdir=/etc \
      --enable-split-usr \
      --enable-lz4 \
      --enable-efi \
      --enable-gnuefi \
      --disable-audit \
      --disable-ima \
      --disable-networkd \
      --without-python \
      --with-default-dnssec=no \
      --without-kill-user-processes \
      --with-ntp-servers="${NTP_SERVERS}" \
      --with-default-hierarchy=hybrid \
      --with-fallback-hostname=KaOS \
      --with-dbuspolicydir=/etc/dbus-1/system.d 
      #--with-firmware-path=/usr/lib/firmware/updates:/lib/firmware/updates:/usr/lib/firmware:/lib/firmware

  make
}

do_check() {
  make -C ${pkg_name}-${pkg_version} check || true
}

do_package() {
  make -C ${pkg_name}-${pkg_version} DESTDIR=${pkg_prefix} install

  install -dm755 ${pkg_prefix}/bin
  ln -s ../usr/lib/systemd/systemd ${pkg_prefix}/bin/systemd

  install -dm755 ${pkg_prefix}/sbin
  for tool in runlevel reboot shutdown poweroff halt telinit; do
    ln -s '/usr/bin/systemctl' ${pkg_prefix}/sbin/$tool
  done

  ln -s '../usr/lib/systemd/systemd' ${pkg_prefix}/sbin/init

  install -d ${pkg_prefix}/sbin
  ln -s ../usr/bin/udevadm ${pkg_prefix}/sbin/udevadm

  ln -s ../lib/systemd/systemd-udevd ${pkg_prefix}/usr/bin/udevd

  install -m644 systemd-${pkg_version}/tmpfiles.d/legacy.conf ${pkg_prefix}/usr/lib/tmpfiles.d

  # Replace in optical 
  sed -i 's#GROUP="dialout"#GROUP="uucp"#g;
          s#GROUP="tape"#GROUP="storage"#g;
          s#GROUP="cdrom"#GROUP="optical"#g' ${pkg_prefix}/usr/lib/udev/rules.d/*.rules
  sed -i 's/dialout/uucp/g;
          s/tape/storage/g;
          s/cdrom/optical/g' ${pkg_prefix}/usr/lib/sysusers.d/basic.conf
          
  # add mkinitcpio hooks
  install -Dm644 ${CACHE_PATH}/initcpio-install-systemd ${pkg_prefix}/usr/lib/initcpio/install/systemd
  install -Dm644 ${CACHE_PATH}/initcpio-install-udev ${pkg_prefix}/usr/lib/initcpio/install/udev
  install -Dm644 ${CACHE_PATH}/initcpio-hook-udev ${pkg_prefix}/usr/lib/initcpio/hooks/udev
  
  rm -r ${pkg_prefix}/usr/lib/rpm
  
  # 208 changed permissions for /var/log/journal
  #install -o root -g systemd-journal -dm2755 ${pkg_prefix}/var/log/journal
  chown root:systemd-journal ${pkg_prefix}/var/log/journal
  chmod 2755 ${pkg_prefix}/var/log/journal{,/remote}
  
  # Make journalctl persistent, set max
  sed -i -e 's|#SystemMaxUse=|SystemMaxUse=25M|' ${pkg_prefix}/etc/systemd/journald.conf
  
  # Install systemd-boot files, ex-gummi
  install -D -m0644 ${CACHE_PATH}/loader.conf ${pkg_prefix}/usr/lib/systemd/boot/loader/loader.conf
  install -D -m0644 ${CACHE_PATH}/KaOS.conf ${pkg_prefix}/usr/lib/systemd/boot/loader/entries/KaOS.conf
  install -D -m0644 ${CACHE_PATH}/KaOS_fallback.conf ${pkg_prefix}/usr/lib/systemd/boot/loader/entries/KaOS_fallback.conf
  install -D -m0644 ${CACHE_PATH}/splash.bmp ${pkg_prefix}/usr/lib/systemd/boot/splash.bmp
  
  # adjust default PAM config
  sed 's|account required pam_unix.so|account  include system-login|g' -i ${pkg_prefix}/etc/pam.d/systemd-user
  sed 's|session optional pam_systemd.so|session  include system-login|g' -i ${pkg_prefix}/etc/pam.d/systemd-user
  
  # pacman hook
  install -Dm644 ../systemd-tmpfiles.hook ${pkg_prefix}/usr/share/libalpm/hooks/systemd-tmpfiles.hook
}


