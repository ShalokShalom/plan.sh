pkg_origin=cosmos

pkg_name=vnstat
pkg_version=1.17
pkg_description="Console-based network traffic monitor for Linux and BSD that keeps
         a log of network traffic for the selected interface(s)"
pkg_upstream_url="https://github.com/vergoh/vnstat"
pkg_license=('GPL')
pkg_deps=('bash' 'gd')
backup=(etc/vnstat.conf)
install=vnstat.install
pkg_source=("http://humdi.net/vnstat/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('8de1c7e40806509943804bb4b26f5409')

do_build() {
  
  ./configure --prefix=/usr --sysconfdir=/etc

  make 
}

do_package() {
  make DESTDIR=${CACHE_PATH} install

  install -Dm0755 examples/vnstat.cgi ${CACHE_PATH}/usr/share/doc/vnstat/examples/vnstat.cgi
  install -Dm0644 examples/systemd/vnstat.service ${CACHE_PATH}/usr/lib/systemd/system/vnstat.service
}
