pkg_origin=cosmos

pkg_name=dbus
pkg_version=1.10.18
pkg_description="Freedesktop.org message bus system"
pkg_upstream_url="http://www.freedesktop.org/Software/dbus"
pkg_license=('GPL' 'custom')
pkg_deps=('expat' 'coreutils' 'filesystem' 'shadow') 
pkg_build_deps=('libx11' 'systemd' 'xmlto')
pkg_source=("http://dbus.freedesktop.org/releases/dbus/dbus-${pkg_version}.tar.gz"
        '30-dbus')
pkg_shasum=('1209c455598165a0c5263d4201894179'
         '3314d727fa57fc443fce25b5cbeebbcc')

do_build() {
  cd dbus-${pkg_version}
  
  ./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var \
      --libexecdir=/usr/lib/dbus-1.0 --with-dbus-user=dbus \
      --with-system-pid-file=/run/dbus/pid \
      --with-system-socket=/run/dbus/system_bus_socket \
      --with-console-auth-dir=/run/console/ \
      --enable-inotify \
      --disable-verbose-mode --disable-static \
      --disable-tests --disable-asserts \
      --with-systemdsystemunitdir=/usr/lib/systemd/system \
      --enable-systemd
  make
}

do_package(){
  cd dbus-${pkg_version}
  make DESTDIR=${pkg_prefix} install

  rm -rf ${pkg_prefix}/var/run

  install -Dm755 ../30-dbus ${pkg_prefix}/etc/X11/xinit/xinitrc.d/30-dbus
  install -Dm644 COPYING ${pkg_prefix}/usr/share/licenses/dbus/COPYING
}
