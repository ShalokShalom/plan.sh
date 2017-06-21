pkg_origin=
 
pkg_name=isowriter
pkg_version=1.1.8
pkg_description="Tool for creating bootable installation USB flash drives"
pkg_upstream_url="https://github.com/KaOSx/isowriter"
pkg_license=('GPLv2')
pkg_deps=('qt5-base' 'kdialog')
pkg_source=("git://github.com/KaOSx/isowriter")
pkg_shasum=('SKIP')

do_build() { 
  cd ${pkg_name}
  
  /usr/lib/qt5/bin/qmake ImageWriter.pro
  make 
}

do_package() {
  cd ${pkg_name}
  
  make INSTALL_ROOT=${pkg_prefix}/ install
  
  for mofile in po/*.mo
  do
    filename=`basename $mofile`
    lang=${filename/.mo/}
    install -D -m 644 $mofile ${pkg_prefix}/usr/share/locale/$lang/LC_MESSAGES/checkisowriter.mo
  done
}
