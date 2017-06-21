pkg_origin=cosmos

pkg_name=openslp
pkg_version=2.0.0
pkg_description="Open-source implementation of Service Location Protocol"
pkg_upstream_url="http://www.openslp.org"
pkg_license=('BSD')
pkg_deps=('glibc' 'bash' 'openssl')
backup=('etc/slp.conf' 'etc/slp.reg' 'etc/slp.spi')
pkg_source=("https://downloads.sourceforge.net/sourceforge/openslp/${pkg_name}-${pkg_version}.tar.gz"
        'openslp.service')
pkg_shasum=('18cf7940bcc444e32592cf34e84f833f'
         '296dc3c8f75e7a1823fcb9dd97ea0971')

do_build() {
  
  ./configure --prefix=/usr \
    --disable-static \
    --sysconfdir=/etc \
    --localstatedir=/var \
    --enable-slpv1 \
    --enable-slpv2-security
  make 
}

do_package() {
  make DESTDIR=${pkg_prefix} install 
  
  install -D -m644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
  install -D -m644 ../openslp.service ${pkg_prefix}/usr/lib/systemd/system/openslp.service
}
