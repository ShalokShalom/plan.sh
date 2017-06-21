pkg_origin=cosmos

pkg_name=xinetd
pkg_version=2.3.15
pkg_description="xinetd is a secure replacement for inetd"
pkg_upstream_url="http://www.xinetd.org/"
pkg_license=('custom')
optpkg_deps=('perl: for xconv.pl script')
backup=('etc/xinetd.conf' 'etc/xinetd.d/servers' 'etc/xinetd.d/services')
pkg_source=("ftp://anduin.linuxfromscratch.org/BLFS/xinetd/xinetd-${pkg_version}.tar.gz"
        'xinetd.conf'
        'servers'
        'services'
        'xinetd.service'
        'CVE-2013-4342.patch')
pkg_shasum=('77358478fd58efa6366accae99b8b04c'
         'f109f699a07bc8cfb5791060f5e87f9e'
         '21f47b4aa20921cfaddddd9f9a407f81'
         '9fa2061dc7dd738c8424251deb86f81e'
         '08466ed714ea8ba42ad81f6fb3aa62e7'
         'b14615c73753ceffbcc96d5e08f3c18d')

do_build() {
  cd ${pkg_name}-${pkg_version}
  sed -i "s#${prefix}/man#${prefix}/share/man#" configure
  # https://bugzilla.redhat.com/show_bug.cgi?id=1006100#c
  patch -p1 -i ${CACHE_PATH}/CVE-2013-4342.patch
  
  ./configure --prefix=/usr --without-libwrap
  make
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  make prefix=${pkg_prefix}/usr install
  
  install -Dm644 ${CACHE_PATH}/xinetd.conf ${pkg_prefix}/etc/xinetd.conf
  install -Dm644 ${CACHE_PATH}/servers ${pkg_prefix}/etc/xinetd.d/servers
  install -Dm644 ${CACHE_PATH}/services ${pkg_prefix}/etc/xinetd.d/services

  # install systemd files
  install -Dm644 ${CACHE_PATH}/xinetd.service ${pkg_prefix}/usr/lib/systemd/system/xinetd.service
  # install license
  install -Dm644 COPYRIGHT ${pkg_prefix}/usr/share/licenses/$pkg_name/COPYRIGHT
}
