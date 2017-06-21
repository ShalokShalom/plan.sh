pkg_origin=cosmos

pkg_name=hdparm
pkg_version=9.52
pkg_description="A shell utility for manipulating Linux IDE drive/driver parameters"
pkg_upstream_url="https://sourceforge.net/projects/hdparm/"
pkg_license=('BSD')
pkg_deps=('glibc')
optpkg_deps=('sh: required by idectl and ultrabayd')
pkg_source=("https://downloads.sourceforge.net/sourceforge/hdparm/${pkg_name}-${pkg_version}.tar.gz"
        'wiper.sh.2_6.max-ranges.patch')
pkg_shasum=('410539d0bf3cc247181594581edbfb53'
         'd91213801094931a02e54283cb1b7375')

do_build() {
  cd ${pkg_name}-${pkg_version}
  patch -p1 -i $CACHE_PATH/wiper.sh.2_6.max-ranges.patch
  
  make
}

do_package() {
  cd ${pkg_name}-${pkg_version}

  mkdir -p ${pkg_prefix}/{usr,sbin}
  make DESTDIR=${pkg_prefix} install
  install -m755 contrib/idectl ${pkg_prefix}/sbin
  install -m755 contrib/ultrabayd ${pkg_prefix}/sbin

  install -D -m 0644 wiper/README.txt ${pkg_prefix}/usr/share/doc/wiper/README.txt
  install -D -m 0755 wiper/wiper.sh ${pkg_prefix}/usr/sbin/wiper.sh
  install -D -m 644 LICENSE.TXT ${pkg_prefix}/usr/share/licenses/hdparm/LICENSE.TXT
}
