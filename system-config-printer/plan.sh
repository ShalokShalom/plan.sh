pkg_origin=

pkg_name=system-config-printer
pkg_version=1.5.9
pkg_description="A CUPS printer configuration tool and status applet"
pkg_upstream_url="https://github.com/zdohnal/system-config-printer"
pkg_license=('GPL')
pkg_deps=('pycups' 'dbus-python3' 'pysmbc' 'libusbx' 'python3-pycurl' 'systemd'
         'python3-gobject3' 'dbus-glib' 'gtk3' 'python3-requests')
pkg_build_deps=('intltool' 'python3' 'xmlto' 'docbook-xsl' 'desktop-file-utils' 'libcups' 'libxml2')
optpkg_deps=('print-manager: for the administration tool in KDE System Settings')
pkg_source=("https://github.com/zdohnal/system-config-printer/releases/download/v${pkg_version}/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('8b449c4b00fb170d79a6b781eab75bb3')

do_build() {
  cd ${pkg_name}-${pkg_version}
  sed -i "s|cups.socket|org.cups.cupsd.socket|g" udev/configure-printer@.service.in
  sed -i "s|gi.require_version('GnomeKeyring', '1.0')|#gi.require_version('GnomeKeyring', '1.0')|g" jobviewer.py
  sed -i "s|from gi.repository import GnomeKeyring|#from gi.repository import GnomeKeyring|g" jobviewer.py

  ./bootstrap
  ./configure --prefix=/usr \
    --sbindir=/usr/bin \
    --sysconfdir=/etc \
    --with-udev-rules \
    --with-udevdir=/usr/lib/udev
  make 
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  
  make DESTDIR=${pkg_prefix} install
  
  #rm ${pkg_prefix}/usr/share/applications/system-config-printer.desktop
}
