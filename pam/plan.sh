pkg_origin=cosmos

pkg_name=pam
pkg_version=1.3.0
pkg_description="PAM (Pluggable Authentication Modules) library"
pkg_license=('GPL2')
pkg_upstream_url="http://www.kernel.org/pub/linux/libs/pam/"
pkg_deps=('glibc' 'db' 'cracklib' 'libtirpc')
pkg_build_deps=('flex' 'w3m' 'docbook-xml>=4.4' 'docbook-xsl')
backup=(etc/security/{access.conf,group.conf,limits.conf,namespace.conf,namespace.init,pam_env.conf,time.conf} etc/pam.d/other etc/default/passwd etc/environment)
pkg_source=("http://www.linux-pam.org/library/Linux-PAM-$pkg_version.tar.bz2"
        #http://www.kernel.org/pub/linux/libs/pam/library/Linux-PAM-$pkg_version.tar.bz2
        "http://sourceforge.net/projects/kaosx/files/sources/pam/pam_unix2-2.9.1.tar.bz2"
        'other'
        'glibc216.patch')
pkg_shasum=('da4b2289b7cfb19583d54e9eaaef1c3a'
         'da6a46e5f8cd3eaa7cbc4fc3a7e2b555'
         '6e6c8719e5989d976a14610f340bd33a'
         '0b5f56559484af741005db19ecfdd709')

do_build() {
  cd $CACHE_PATH/Linux-PAM-$pkg_version
  
  ./configure \
        CFLAGS="$CFLAGS -I$CACHE_PATH/Linux-PAM-$pkg_version/libpam/include/" \
        LDFLAGS="$LDFLAGS -L$CACHE_PATH/Linux-PAM-$pkg_version/libpam/.libs/" \
        --libdir=/usr/lib
  make

  # check to remove soon, Suse maintenance of pam_unix2 stopped years ago
  # source ftp://ftp.suse.com/pub/people/kukuk/pam/pam_unix2 no longer available
  cd $CACHE_PATH/pam_unix2-2.9.1
  patch -p1 -i ../glibc216.patch
  
  ./configure --libdir=/usr/lib
  make
}

do_package() {
  cd $CACHE_PATH/Linux-PAM-$pkg_version
  make DESTDIR=$pkg_prefix install
  install -D -m644 ../other $pkg_prefix/etc/pam.d/other

  cd $CACHE_PATH/pam_unix2-2.9.1
  make DESTDIR=$pkg_prefix install

  sed -i 's|# End of file||' $pkg_prefix/etc/security/limits.conf
  cat >>$pkg_prefix/etc/security/limits.conf <<_EOT
*               -       rtprio          0
*               -       nice            0
@audio          -       rtprio          65
@audio          -       nice           -10
@audio          -       memlock         40000
_EOT

  cd $pkg_prefix/usr/lib/security
  ln -s pam_unix.so pam_unix_acct.so
  ln -s pam_unix.so pam_unix_auth.so
  ln -s pam_unix.so pam_unix_passwd.so
  ln -s pam_unix.so pam_unix_session.so

  chmod +s $pkg_prefix/sbin/unix_chkpwd
}

