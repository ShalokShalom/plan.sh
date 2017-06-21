pkg_origin=cosmos

pkg_name=mobile-broadband-provider-info
pkg_version=20170310
pkg_description="Mobile broadband settings for various service providers"
pkg_upstream_url="https://git.gnome.org/browse/mobile-broadband-provider-info/"
pkg_license=('CC-PD')
pkg_source=("https://git.gnome.org/browse/mobile-broadband-provider-info/snapshot/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('b2be8ce8ef384d0617051d8421e587bb')

do_build() {
  
  ./autogen.sh  
  ./configure --prefix=/usr
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
