pkg_origin=cosmos

pkg_name=emacs-nox
pkg_version=25.2
pkg_description='The Emacs Editor, without X11 support'
pkg_upstream_url="https://www.gnu.org/software/emacs/emacs.html"
pkg_license=('GPL3')
pkg_deps=('dbus' 'ncurses' 'perl' 'gpm' 'libxpm')
pkg_source=("https://ftp.gnu.org/gnu/emacs/emacs-${pkg_version}.tar.xz")
pkg_shasum=('06442d867158754bdde793eca420ca49')

do_build() {

  ./configure --prefix=/usr \
    --sysconfdir=/etc \
    --libexecdir=/usr/lib \
    --localstatedir=/var \
    --without-x \
    --without-sound
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install

  #remove conflicts
  mv ${pkg_prefix}/usr/bin/{ctags,ctags.emacs}
  mv ${pkg_prefix}/usr/share/man/man1/{ctags.1.gz,ctags.emacs.1}
  rm ${pkg_prefix}/usr/share/info/info.info.gz
  
  #fix all the 777 perms on directories
  find ${pkg_prefix}/usr/share/emacs/$pkg_version -type d -exec chmod 755 {} \;
  #fix user/root permissions on usr/share files
  find ${pkg_prefix}/usr/share/emacs/$pkg_version -exec chown root.root {} \;
  #remove .desktop file and icons
  rm -rf ${pkg_prefix}/usr/share/{applications,icons}

  # fix perms on /var/games
  chmod 775 ${pkg_prefix}/var/games
  chmod 775 ${pkg_prefix}/var/games/emacs
  chmod 664 ${pkg_prefix}/var/games/emacs/*
  chown -R root:games ${pkg_prefix}/var/games
}
