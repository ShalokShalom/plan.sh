pkg_origin=cosmos

pkg_name=networkmanager-openvpn
_pkg_name=NetworkManager-openvpn
pkg_version=1.2.10
_pkg_version=1.2
pkg_description="NetworkManager VPN plugin for OpenVPN"
pkg_license=('GPL')
pkg_upstream_url="https://wiki.gnome.org/Projects/NetworkManager"
pkg_deps=('networkmanager' 'openvpn')
pkg_build_deps=('intltool') 
install=${pkg_name}.install
pkg_source=("https://ftp.gnome.org/pub/GNOME/sources/NetworkManager-openvpn/${_pkg_version}/${_pkg_name}-${pkg_version}.tar.xz"
        'nm-openvpn.conf')
pkg_shasum=('f118226ed2bfbacfd64ac4d1e0bd0383'
         '22305c06a665ae75221f7202676976c2')

do_build() {
  
  ./configure --prefix=/usr \
  	--sysconfdir=/etc \
	--libexecdir=/usr/lib/networkmanager \
	--localstatedir=/var \
    --without-gnome \
	--disable-static \
	--disable-more-warnings
	#--without-libnm-glib
  make 
}

do_package() {
  make DESTDIR=${pkg_prefix} install 
  
  install -D -m 0644 ../nm-openvpn.conf ${pkg_prefix}/usr/lib/sysusers.d/nm-openvpn.conf
}
