pkg_origin=cosmos

pkg_name=logrotate
pkg_version=3.12.2
pkg_description="Rotates system logs automatically"
pkg_upstream_url='https://github.com/logrotate/logrotate'
pkg_license=('GPL')
pkg_deps=('popt' 'gzip' 'acl')
backup=('etc/logrotate.conf')
pkg_source=("https://github.com/logrotate/logrotate/releases/download/${pkg_version}/${pkg_name}-${pkg_version}.tar.xz"
        'logrotate.conf')
pkg_shasum=('923e753825405280aebcc4e73b4b2b55'
         '416de14f92ef4361adad8b6e7065245a')

do_build() {
  cd ${pkg_name}-${pkg_version}
  
  ./configure --prefix=/usr \
    --mandir=/usr/share/man \
    --with-acl \
    --with-state-file-path=/var/lib/logrotate.status \
    --with-default-mail-command=/usr/bin/mail \
    --with-compress-command=/usr/bin/gzip \
    --with-uncompress-command=/usr/bin/gunzip \
    --with-compress-extension=.gz
  
  make 
}

do_check() {
  cd ${pkg_name}-${pkg_version}
  
  make test
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  make DESTDIR=$pkg_prefix install
  
  install -dm755 $pkg_prefix/etc/logrotate.d
  install -Dm644 $CACHE_PATH/logrotate.conf $pkg_prefix/etc/logrotate.conf
  
  install -D -m644 examples/logrotate.timer ${pkg_prefix}/usr/lib/systemd/system/logrotate.timer
  install -D -m644 examples/logrotate.service ${pkg_prefix}/usr/lib/systemd/system/logrotate.service
  install -d -m755 ${pkg_prefix}/usr/lib/systemd/system/multi-user.target.wants
  ln -s ../logrotate.timer ${pkg_prefix}//usr/lib/systemd/system/multi-user.target.wants/logrotate.timer
}
