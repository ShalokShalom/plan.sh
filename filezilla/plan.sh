pkg_origin=

pkg_name=filezilla
_pkg_name=FileZilla
pkg_version=3.26.2
pkg_description="Fast and reliable FTP, FTPS and SFTP client."
pkg_upstream_url="https://filezilla-project.org/"
pkg_license=('GPL2')
pkg_deps=('dbus' 'hicolor-icon-theme' 'libidn' 'libjpeg-turbo' 'xdg-utils' 'wxgtk' 'sqlite'
         'libfilezilla' 'pugixml' 'gnutls')
pkg_source=("https://downloads.sourceforge.net/project/filezilla/${_pkg_name}_Client/${pkg_version}/${_pkg_name}_${pkg_version}_src.tar.bz2"
        'filezilla.desktop')
pkg_shasum=('0c82dc925de59334266a9c2d119d546a'
         '18fe9dc5377f1a84f71f78eae4cca7f9')

do_build() {
  cd ${pkg_name}-${pkg_version}

  ./configure --prefix=/usr \
    --disable-manualupdatecheck \
    --disable-autoupdatecheck \
    --disable-static \
    --with-pugixml=system
  make
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  make DESTDIR=${pkg_prefix} install
  
  rm ${pkg_prefix}/usr/share/applications/filezilla.desktop
  install -D -m644 ${CACHE_PATH}/filezilla.desktop ${pkg_prefix}/usr/share/applications/filezilla.desktop
}
