pkg_origin=cosmos

pkg_name=gpm
pkg_version=1.20.7
pkg_description="A mouse server for the console and xterm"
pkg_upstream_url="http://unix.schottelius.org/gpm/"
pkg_license=('GPL')
pkg_deps=('ncurses' 'bash')
pkg_source=("http://www.nico.schottelius.org/software/gpm/archives/${pkg_name}-${pkg_version}.tar.lzma"
        'gpm.sh'
        'gpm.service')
pkg_shasum=('fa8a6fe09826896625ca557ac5e42ed7'
         'e391fe4599ce102615f9cd449c380d41'
         '5e5547fb272befeeb8bcb07fa2426c5e')

do_build() {
  cd ${pkg_name}-${pkg_version}
  
  ./autogen.sh
  ./configure --prefix=/usr --sysconfdir=/etc
  make
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  make DESTDIR=${pkg_prefix} install
  
  install -D -m755 ../gpm.sh ${pkg_prefix}/etc/profile.d/gpm.sh
  install -D -m644 ../gpm.service ${pkg_prefix}/usr/lib/systemd/system/gpm.service

# library fixes
  cd ${pkg_prefix}/usr/lib/
  ln -s libgpm.so.2.* libgpm.so
  chmod 755 ${pkg_prefix}/usr/lib/libgpm.so.*
}
