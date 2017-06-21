pkg_origin=cosmos

pkg_name=libteam
pkg_version=1.23
pkg_description="Driver to provide a mechanism to team multiple NICs (ports) into one logical one (teamdev) at L2 layer"
pkg_upstream_url="http://libteam.org/"
pkg_license=('LGPL2.1')
pkg_deps=('libnl' 'libdaemon' 'jansson' 'dbus' 'bash' 'zeromq')
pkg_build_deps=('python2' 'swig')
pkg_source=("http://libteam.org/files/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('ed5859ab96cbaa365400c771f995ac8d')

do_build() {

  ./configure --prefix=/usr \
        --sysconfdir=/etc \
        --localstatedir=/var \
        --disable-static \
        --libexecdir=/usr/lib
  make
}

check() {

  make check
}

do_package() {
  make DESTDIR=${pkg_prefix} install

  install -Dm644 teamd/redhat/systemd/teamd@.service ${pkg_prefix}/usr/lib/systemd/system/teamd@.service
  install -Dm644 teamd/dbus/teamd.conf ${pkg_prefix}/etc/dbus-1/system.d/teamd.conf
}

