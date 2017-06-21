pkg_origin=cosmos

pkg_name=colord
pkg_version=1.3.4
pkg_description="System service easily manage, install and generate color profiles to manage input and output devices"
pkg_upstream_url="http://www.freedesktop.org/software/colord"
pkg_license=('GPL2')
pkg_deps=('lcms2' 'polkit' 'sqlite3' 'systemd' 'libgusb' 'dbus' 'libgudev')
pkg_build_deps=('intltool' 'gobject-introspection' 'vala' 'docbook-xsl' 'sane' 'bash-completion')
oppkg_deps=('sane')
install=colord.install
pkg_source=("http://www.freedesktop.org/software/colord/releases/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('5e889426907a0436ecfbdb18add2c67b')

do_build() {
  
  ./configure --prefix=/usr \
    --sysconfdir=/etc \
    --libexecdir=/usr/lib/colord \
    --localstatedir=/var \
    --disable-static \
    --with-systemdsystemunitdir=/usr/lib/systemd/system \
    --with-daemon-user=colord \
    --enable-vala \
    --enable-sane \
    --disable-argyllcms-sensor
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
  chown -R 124:124 ${pkg_prefix}/var/lib/colord
}

