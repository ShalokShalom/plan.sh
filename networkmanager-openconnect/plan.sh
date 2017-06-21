pkg_origin=cosmos

pkg_name=networkmanager-openconnect
pkg_version=1.2.4
_pkg_version=1.2
pkg_description="NetworkManager VPN integration for openconnect"
pkg_license=('GPL')
pkg_upstream_url="http://www.gnome.org/projects/NetworkManager/"
pkg_deps=('networkmanager' 'openconnect' 'dbus-glib')
pkg_build_deps=('intltool') 
install=$pkg_name.install
pkg_source=("https://download.gnome.org/sources/NetworkManager-openconnect/${_pkg_version}/NetworkManager-openconnect-${pkg_version}.tar.xz")
pkg_shasum=('c0a5086e495166c52d306132672aa1d3')

do_build() {
  
  ./configure --prefix=/usr \
  	--sysconfdir=/etc \
	--libexecdir=/usr/lib/networkmanager \
    --without-gnome \
	--disable-static 
  make 
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install 
}
