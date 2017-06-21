pkg_origin=cosmos

pkg_name=mtools
pkg_version=4.0.18
pkg_description="A collection of utilities to access MS-DOS disks"
pkg_upstream_url="https://www.gnu.org/software/mtools/"
pkg_license=('GPL')
pkg_deps=('sh' 'libx11' 'libsm')
pkg_build_deps=('texinfo')
backup=('etc/mtools.conf')
pkg_source=("https://ftp.gnu.org/gnu/mtools/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('a23646617546bf6ad56f061d8b283c85')

do_build() {

  sed -i '/^SAMPLE FILE$/s:^:# :' mtools.conf
  ./configure --prefix=/usr \
              --mandir=/usr/share/man \
              --infodir=/usr/share/info \
	      --sysconfdir=/etc
  make
}

do_package() {

  make -j 1 DESTDIR=${pkg_prefix} install
  install -Dm644 mtools.conf ${pkg_prefix}/etc/mtools.conf
}
