pkg_origin=cosmos

pkg_name=networkmanager-vpnc
pkg_version=1.2.4
_pkg_version=1.2
pkg_description="NetworkManager VPN plugin for vpnc"
pkg_license=('GPL')
pkg_upstream_url="http://www.gnome.org/projects/NetworkManager/"
pkg_deps=('networkmanager' 'vpnc')
pkg_build_deps=('intltool') 
pkg_source=("http://ftp.gnome.org/pub/GNOME/sources/NetworkManager-vpnc/${_pkg_version}/NetworkManager-vpnc-${pkg_version}.tar.xz")
pkg_shasum=('b482a231f25d3857fd320d7c0b25c785')

do_build() {
  
  ./configure --prefix=/usr \
  	--sysconfdir=/etc \
	--libexecdir=/usr/lib/networkmanager \
	--localstatedir=/var \
    --without-gnome \
	--disable-static \
	--disable-more-warnings
  make 
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install 
}
