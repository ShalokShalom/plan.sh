pkg_origin=cosmos

pkg_name=cdrtools
pkg_version=3.02a07
_pkg_version=3.02
pkg_description="Original cdrtools supporting CD, DVD and BluRay burning"
pkg_upstream_url="http://cdrecord.org/"
pkg_license=('CDDL')
pkg_deps=('acl' 'libcap')
backup=('etc/default/cdrecord' 'etc/default/rscsi')
install=cdrtools.install
pkg_source=("https://downloads.sf.net/cdrtools/cdrtools-${pkg_version}.tar.bz2")
pkg_shasum=('ea362a6a42d8aa0d5fc154d195f47926')

do_build() {
  sed -i 's|/opt/schily|/usr|g' DEFAULTS/Defaults.linux
  sed -i 's|DEFINSGRP=.*|DEFINSGRP=root|' DEFAULTS/Defaults.linux
  # install rscsi to /usr/bin instead of /usr/sbin
  sed -i 's|INSDIR=.*|INSDIR=bin|' rscsi/Makefile
  
  export GMAKE_NOWARN=true
  make INS_BASE=/usr INS_RBASE=/
}

do_package() {

  export GMAKE_NOWARN=true
  make INS_BASE=/usr INS_RBASE=/ DESTDIR=${pkg_prefix} install
  rm -rf ${pkg_prefix}/usr/include
  rm -rf ${pkg_prefix}/usr/lib/{*.a,profiled}

  # autoload 'sg' module needed by cdrecord
  install -d -m755 ${pkg_prefix}/usr/lib/modules-load.d/
  echo sg > ${pkg_prefix}/usr/lib/modules-load.d/cdrecord.conf

  # create symlinks for cdrkit compatibility
  ln -s cdrecord wodim
  ln -s readcd readom
  ln -s mkisofs genisoimage
  ln -s cdda2wav icedax
  
  # conflicts with man-pages
  rm -rf ${pkg_prefix}/usr/share/man/man3
}
