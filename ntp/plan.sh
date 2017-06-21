pkg_origin=cosmos

pkg_name=ntp
pkg_version=4.2.8.10
_pkg_version=4.2.8p10
pkg_description="NTP (Network Time Protocol) tries to keep servers in sync"
pkg_license=('custom')
pkg_upstream_url="http://www.ntp.org/"
pkg_deps=('openssl' 'readline' 'libcap' 'libedit')
backup=('etc/ntp.conf')
install=install
pkg_source=("http://archive.ntp.org/ntp4/ntp-4.2/ntp-${_pkg_version}.tar.gz"
        'ntp.conf'
        'ntpd.service'
        'ntpdate.service')
pkg_shasum=('745384ed0dedb3f66b33fe84d66466f9'
         '086ad240f3ae42b15cc8dfa8682107e7'
         '1edc815c2fe37bbe1170d2d132dc623a'
         '24f0e0aae19b2c1cd4a84cb9c0d0c934')

do_build() {
  
  ./configure --prefix=/usr \
      --mandir=/usr/share/man \
      --libexecdir=/usr/lib \
      --enable-linuxcaps \
      --enable-ntp-signd 
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install
  
  install -d -o 87 ${pkg_prefix}/var/lib/ntp
  echo > ${pkg_prefix}/var/lib/ntp/.placeholder
  
  install -Dm644 ../ntp.conf ${pkg_prefix}/etc/ntp.conf
  install -Dm644 ../ntpd.service ${pkg_prefix}/usr/lib/systemd/system/ntpd.service
  install -Dm644 ../ntpdate.service ${pkg_prefix}/usr/lib/systemd/system/ntpdate.service
  install -Dm644 COPYRIGHT ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
