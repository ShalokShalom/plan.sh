pkg_origin=cosmos

pkg_name=upower
pkg_version=0.99.4
pkg_description="Abstraction for enumerating power devices, listening to device events and querying history and statistics"
pkg_upstream_url="https://upower.freedesktop.org"
pkg_license=('GPL')
pkg_deps=('systemd' 'libgudev' 'libusb' 'polkit' 'dbus-glib' 'libimobiledevice')
pkg_build_deps=('pkg-config' 'intltool' 'docbook-xsl')
install=upower.install
pkg_source=("https://upower.freedesktop.org/releases/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('78800e1ac7f92b24aabdf433e38f75d2')

do_build() {
  #patch -p1 -i "${CACHE_PATH}"/fix-segfault.patch

  ./configure --prefix=/usr \
      --sysconfdir=/etc \
      --localstatedir=/var \
      --libexecdir=/usr/lib/upower \
      --with-systemdsystemunitdir=/usr/lib/systemd/system \
      --disable-static \
      --enable-deprecated
  make
}

do_package() {
  
  make DESTDIR=${CACHE_PATH} install
}
