pkg_origin=cosmos

pkg_name=cdrdao
pkg_version=1.2.3
pkg_license=('GPL')
pkg_upstream_url="http://cdrdao.sourceforge.net/"
pkg_description='Records audio/data CD-Rs in disk-at-once (DAO) mode'
pkg_deps=('gcc-libs' 'lame' 'libmad' 'libvorbis' 'libao')
pkg_build_deps=('libsigc++')
pkg_source=("http://downloads.sourceforge.net/${pkg_name}/${pkg_name}-${pkg_version}.tar.bz2"
	'cdrdao-1.2.3-autoconf-update.patch'
        'cdrdao-1.2.3-k3b.patch'
        'cdrdao-1.2.3-stat.patch')
pkg_shasum=('8d15ba6280bb7ba2f4d6be31d28b3c0c'
         '8e53dfc174f7c0882194caa05e68b85e'
         '696f6ca01e1eeb9b6a5be88e535d9398'
         '0fce05542ebad283f36fa1c4d62992a0')

do_build() {
	patch -p1 -i "${CACHE_PATH}/cdrdao-1.2.3-autoconf-update.patch"
	patch -p1 -i "${CACHE_PATH}/cdrdao-1.2.3-k3b.patch"
	patch -p1 -i "${CACHE_PATH}/cdrdao-1.2.3-stat.patch"
  
	./configure --prefix=/usr \
	   --mandir=/usr/share/man \
	   --sysconfdir=/etc \
	   --with-xdao --with-lame \
	   --with-ogg-support --with-mp3-support
	make
}

do_package() {
	for dir in trackdb utils paranoia dao
	do
	     make -C ${dir} DESTDIR=${pkg_prefix} install
	done
}

