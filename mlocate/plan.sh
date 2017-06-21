pkg_origin=cosmos

pkg_name=mlocate
pkg_version=0.26
pkg_description="Faster merging drop-in for slocate"
pkg_upstream_url="https://pagure.io/mlocate"
pkg_license=('GPL')
pkg_deps=('glibc' 'coreutils' 'sh')
backup=('etc/updatedb.conf')
pkg_source=("https://releases.pagure.org/mlocate/mlocate-$pkg_version.tar.xz"
	'updatedb.conf'
	'updatedb.timer'
	'updatedb.service')
pkg_shasum=('539e6f86bf387358aa2b14d5f880e49a'
         'b56d81de17fe29b01b4b28861acb8fd4'
         '1b4a1d2a16de577070b4e9b5aad3eea9'
         '8d7bfb770a97b30ae430999359628cc0')

do_build() {
  cd $pkg_name-$pkg_version

  sed -i '/^groupname /s/mlocate/locate/' Makefile.in
  ./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var/lib
  make

}

do_check() {
  cd $pkg_name-$pkg_version
  make check
}

do_package() {
  cd $pkg_name-$pkg_version
  make DESTDIR=$pkg_prefix install

  ln -sv locate $pkg_prefix/usr/bin/slocate
  chgrp -v 21 $pkg_prefix/usr/bin/locate
  chmod -v 2755 $pkg_prefix/usr/bin/locate
  
  install -Dm644 ${CACHE_PATH}/updatedb.conf $pkg_prefix/etc/updatedb.conf

  install -dm755 $pkg_prefix/var/lib
  install -d -m750 -g21 $pkg_prefix/var/lib/locate
  
  install -D -m644 ${CACHE_PATH}/updatedb.timer ${pkg_prefix}/usr/lib/systemd/system/updatedb.timer
  install -D -m644 ${CACHE_PATH}/updatedb.service ${pkg_prefix}/usr/lib/systemd/system/updatedb.service
  install -d -m755 ${pkg_prefix}/usr/lib/systemd/system/multi-user.target.wants
  ln -s ../updatedb.timer ${pkg_prefix}//usr/lib/systemd/system/multi-user.target.wants/updatedb.timer
}

