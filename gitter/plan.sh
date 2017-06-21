pkg_origin=

pkg_name=gitter
pkg_version=3.1.0
pkg_description='Chat client build on top of github, tightly integrated with repositories'
pkg_upstream_url='https://gitter.im'
pkg_license=('MIT')
pkg_deps=('systemd' 'gtk2' 'gconf')
pkg_source=("https://update.gitter.im/linux64/gitter_${pkg_version}_amd64.deb")
noextract=("gitter_${pkg_version}_amd64.deb")
pkg_shasum=('dcd92ad435c126c89b28089aec25fe94')

do_package() {
  bsdtar -xf gitter_${pkg_version}_amd64.deb data.tar.gz  
  bsdtar -xf data.tar.gz -C ${pkg_prefix}
	rm data.tar.gz

  mkdir -p ${pkg_prefix}/usr/lib
  ln -sf /usr/lib/libudev.so.1 ${pkg_prefix}/usr/lib/libudev.so.0

  mkdir -p ${pkg_prefix}/usr/share/applications
  mv -f ${pkg_prefix}/opt/Gitter/linux64/gitter.desktop ${pkg_prefix}/usr/share/applications/
  
  rm -rf ${pkg_prefix}/usr/share/doc
}
