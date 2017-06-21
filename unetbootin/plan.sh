pkg_origin=

pkg_name=unetbootin
pkg_version=619
pkg_description="Allows the creation of bootable Live USB drives."
pkg_upstream_url="http://unetbootin.github.io/"
pkg_license=('GPL3')
pkg_deps=('polkit' 'libpng' 'mtools' 'p7zip' 'qt' 'syslinux') 
pkg_source=("https://github.com/unetbootin/unetbootin/archive/$pkg_version.tar.gz")
pkg_shasum=('e06ae0b2c0d5ca04318e5c34b9acd9da')

do_build() {
  cd $CACHE_PATH/$pkg_name-$pkg_version/src/unetbootin
  lupdate $pkg_name.pro
  lrelease $pkg_name.pro
  qmake
  make
}

do_package() {
  # Executable 
  install -Dm755 $CACHE_PATH/$pkg_name-$pkg_version/src/unetbootin/$pkg_name $pkg_prefix/usr/bin/$pkg_name

  # Translations 
  mkdir -p $pkg_prefix/usr/share/$pkg_name
  install -m644 $CACHE_PATH/$pkg_name-$pkg_version/src/unetbootin/$pkg_name_*.qm $pkg_prefix/usr/share/$pkg_name/

  install -Dm644 $CACHE_PATH/$pkg_name-$pkg_version/src/unetbootin/$pkg_name.desktop $pkg_prefix/usr/share/applications/$pkg_name.desktop
  install -Dm644 $CACHE_PATH/$pkg_name-$pkg_version/src/unetbootin/${pkg_name}_48.png $pkg_prefix/usr/share/pixmaps/$pkg_name.png
}
