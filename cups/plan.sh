pkg_origin=cosmos

pkgbase="cups"
pkg_name=('libcups' 'cups')
pkg_version=2.2.3
pkg_license=('GPL')
pkg_upstream_url="http://www.cups.org/"
pkg_build_deps=('libtiff' 'libpng' 'acl' 'pam' 'xdg-utils' 'krb5' 'openssl' 'cups-filters' 'bc'
             'xinetd' 'gzip' 'autoconf' 'libusb' 'dbus' 'avahi'  'hicolor-icon-theme' 'systemd'
             'colord' 'libpaper' 'gnutls')
pkg_source=("https://github.com/apple/cups/releases/download/v${pkg_version}/cups-${pkg_version}-source.tar.gz"
        'cups-no-export-ssllibs.patch'
        'cups-no-gcrypt.patch'
        'cups-no-gzip-man.patch'
        'cups.logrotate'
        'cups.pam')
pkg_shasum=('006a8156680a516e43c59034e31df8bf'
         '3ba9e3410df1dc3015463d615ef91b3b'
         '928b4ec806db4170179ad4d1c8074ff9'
         '90c30380d4c8cd48a908cfdadae1ea24'
         'ec2fdabb60b430ce1fb643078e9fc7c0'
         '96f82c38f3f540b53f3e5144900acf17')

do_build() {
  patch -p1 -i ${CACHE_PATH}/cups-no-export-ssllibs.patch
  patch -p1 -i ${CACHE_PATH}/cups-no-gcrypt.patch
  #patch -p1 -i ${CACHE_PATH}/cups-no-gzip-man.patch
  
  aclocal -I config-scripts
  autoconf -I config-scripts

  ./configure --prefix=/usr \
     --sysconfdir=/etc \
     --localstatedir=/var \
     --libdir=/usr/lib \
     --with-logdir=/var/log/cups \
     --with-docdir=/usr/share/cups/doc \
     --with-cups-user=daemon \
     --with-cups-group=lp \
     --enable-pam=yes \
     --enable-raw-printing \
     --enable-dbus \
     --with-dbusdir=/etc/dbus-1 \
     --enable-ssl=yes \
     --enable-threads \
     --enable-avahi\
     --enable-libpaper \
     --with-php=/usr/bin/php-cgi \
     --with-optim="$CFLAGS"
  make
}

check() {

  #make -k check || /bin/true
}

package_libcups() {
pkg_description="The CUPS Printing System - client libraries and headers"
pkg_deps=('gnutls' 'libtiff' 'libpng' 'krb5' 'avahi')
backup=(etc/cups/client.conf)

  make BUILDROOT=${pkg_prefix} install-headers install-libs
 
  mkdir -p ${pkg_prefix}/usr/bin 
  install -m755 ${CACHE_PATH}/${pkgbase}-${pkg_version}/cups-config ${pkg_prefix}/usr/bin/cups-config
  
  install -dm755 ${pkg_prefix}/usr/share/man/man5
  #install -Dm644  ${CACHE_PATH}/${pkgbase}-${pkg_version}/man/client.conf.5.gz ${pkg_prefix}/usr/share/man/man5/
  install -Dm644  ${CACHE_PATH}/${pkgbase}-${pkg_version}/man/client.conf.man ${pkg_prefix}/usr/share/man/man5/
  install -dm755 ${pkg_prefix}/etc/cups
  touch ${pkg_prefix}/etc/cups/client.conf
  echo "# see 'man client.conf'" >> ${pkg_prefix}/etc/cups/client.conf
  echo "ServerName /run/cups/cups.sock #  alternative: ServerName hostname-or-ip-address[:port] of a remote server" >> ${pkg_prefix}/etc/cups/client.conf
  chgrp lp ${pkg_prefix}/etc/cups/client.conf
}

package_cups() {
pkg_description="The CUPS Printing System - daemon package"
install=cups.install
backup=(etc/cups/cupsd.conf
        etc/cups/snmp.conf
        etc/cups/printers.conf
        etc/cups/classes.conf
        etc/cups/cups-files.conf
        etc/cups/subscriptions.conf
        etc/dbus-1/system.d/cups.conf
        etc/logrotate.d/cups
        etc/pam.d/cups)
pkg_deps=('acl' 'pam' "libcups>=${pkg_version}" 'cups-filters' 'bc' 'colord' 'libusb' 'dbus' 'systemd'
         'hicolor-icon-theme' 'libpaper')
pkg_deps=('xdg-utils: xdg .desktop file support')

  make BUILDROOT=${pkg_prefix} install-data install-exec

  # part of libcups
  rm -f ${pkg_prefix}/usr/bin/cups-config

  rm -rf ${pkg_prefix}/etc/rc*.d
  rm -rf ${pkg_prefix}/etc/init.d
  
  install -D -m644 ../cups.logrotate ${pkg_prefix}/etc/logrotate.d/cups
  install -D -m644 ../cups.pam ${pkg_prefix}/etc/pam.d/cups
  
  chmod 755 ${pkg_prefix}/var/spool
  chmod 775 ${pkg_prefix}/var/cache/cups
  chmod 755 ${pkg_prefix}/etc

  # certs dir
  install -dm700 -g lp ${pkg_prefix}/etc/cups/ssl
  # created with cupsd 
  rm -rf ${pkg_prefix}/var/run

  # cupsd conf files
  touch ${pkg_prefix}/etc/cups/printers.conf
  touch ${pkg_prefix}/etc/cups/classes.conf
  touch ${pkg_prefix}/etc/cups/subscriptions.conf 
  chgrp lp ${pkg_prefix}/etc/cups/{printers.conf,classes.conf,subscriptions.conf}
  
  # .desktop file
  sed -i 's|^Exec=htmlview http://localhost:631/|Exec=xdg-open http://localhost:631/|g' ${pkg_prefix}/usr/share/applications/cups.desktop
  
  find ${pkg_prefix}/usr/share/cups/model -name "*.ppd" | xargs gzip -n9f
  
  #rm -f ${pkg_prefix}/usr/share/man/man5/client.conf.5
  
  # part of cups-filters
  #rm -v ${pkg_prefix}/usr/share/cups/banners/*
  #rm -v ${pkg_prefix}/usr/share/cups/data/testprint
}
