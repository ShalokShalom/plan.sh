pkg_origin=cosmos

pkg_name=avahi
pkg_version=0.6.32
_pkg_version=0.6.32
pkg_description="A multicast/unicast DNS-SD framework"
pkg_upstream_url="http://www.avahi.org/"
pkg_license=('LGPL')
pkg_deps=('dbus' 'libcap' 'libdaemon' 'gdbm' 'glib2' 'expat')
pkg_build_deps=('dbus-python2' 'gobject-introspection' 'intltool')
backup=(etc/avahi/avahi-daemon.conf etc/avahi/services/{sftp-,}ssh.service)
install=avahi.install
#pkg_source=("http://www.avahi.org/download/avahi-${pkg_version}.tar.gz")
pkg_source=("https://github.com/lathiat/avahi/releases/download/v${_pkg_version}/${pkg_name}-${_pkg_version}.tar.gz")
pkg_shasum=('22b5e705d3eabb31d26f2e1e7b074013')

prepare() {
  
  NOCONFIGURE=1 ./autogen.sh
}

do_build() {

    ./configure --prefix=/usr \
    --sysconfdir=/etc \
    --localstatedir=/var \
    --disable-static \
    --disable-qt3 \
    --disable-qt4 \
    --disable-mono \
    --disable-monodoc \
    --disable-doxygen-doc \
    --disable-xmltoman \
    --disable-manpages \
    --disable-gtk \
    --disable-gtk3 \
    --disable-pygtk \
    --enable-compat-libdns_sd \
    --enable-compat-howl \
    --with-distro=none \
    --with-avahi-priv-access-group=network \
    --with-autoipd-user=avahi \
    --with-autoipd-group=avahi \
    --with-systemdsystemunitdir=/usr/lib/systemd/system

  make 
}

do_package() {
	make DESTDIR=${pkg_prefix} install
	
	rm ${pkg_prefix}/var -rfv
	rm -fr ${pkg_prefix}/etc/rc.d

	sed -i '1c #!/usr/bin/python2' usr/bin/avahi-bookmarks
	# howl and mdnsresponder compatability
	(cd usr/include; ln -s avahi-compat-libdns_sd/dns_sd.h dns_sd.h; ln -s avahi-compat-howl howl)
	(cd usr/lib/pkgconfig; ln -s avahi-compat-howl.pc howl.pc)
}

