pkg_origin=cosmos

pkg_name=networkmanager-pptp
pkg_version=1.2.4
_pkg_version=1.2
_pppver=2.4.7
pkg_description="NetworkManager VPN plugin for pptp "
pkg_license=('GPL')
pkg_upstream_url="http://www.gnome.org/projects/NetworkManager/"
pkg_deps=('networkmanager' 'pptpclient')
pkg_build_deps=('intltool' 'python3')
pkg_source=("http://ftp.gnome.org/pub/GNOME/sources/NetworkManager-pptp/${_pkg_version}/NetworkManager-pptp-${pkg_version}.tar.xz")
pkg_shasum=('a05b36c92870e2e248c0c75b2c7ef577')

do_build() {
  
  ./configure --prefix=/usr \
  	--sysconfdir=/etc \
	--libexecdir=/usr/lib/networkmanager \
    --without-gnome \
	--disable-static \
	--with-pppd-plugin-dir=/usr/lib/pppd/${_pppver}
  make 
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install 
}
