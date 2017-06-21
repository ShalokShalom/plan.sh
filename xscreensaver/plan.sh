pkg_origin=cosmos

pkg_name=xscreensaver
pkg_version=5.36
pkg_description="Screen saver and locker for the X Window System"
pkg_upstream_url="http://www.jwz.org/xscreensaver/"
pkg_license=('BSD')
pkg_deps=('mesa' 'pam' 'xorg-res-utils' 'libxmu' 'libjpeg-turbo' 'libglade' 'glu')
pkg_build_deps=('bc' 'intltool' 'libxpm' 'mesa')
backup=('etc/pam.d/xscreensaver')
pkg_source=("http://www.jwz.org/xscreensaver/${pkg_name}-${pkg_version}.tar.gz"
        'add-electricsheep.diff'
        'LICENSE')
pkg_shasum=('79dc3349df1fe978825991ce71a4a220'
         '259e8bdb61b3a7c6f752c81e72afe4cf'
         '5e7f3f2a63d20a484742f5b4cb5d572c')


do_build() {
  patch -p0 -i ${CACHE_PATH}/add-electricsheep.diff
  sed -i 's|(HAVE_COCOA)  // Real X11|(HAVE_COCOA)  /* Real X11 */|' utils/grabclient.c
  sed -i 's|(HAVE_COCOA)   // Desktop OSX|(HAVE_COCOA)   /* Desktop OSX */|' utils/grabclient.c
  
  ./configure --prefix=/usr \
    --sysconfdir=/etc \
    --localstatedir=/var \
    --libexecdir=/usr/lib \
    --with-x-app-defaults=/usr/share/X11/app-defaults \
    --with-pam \
    --without-motif \
    --with-gtk \
    --with-gl \
    --without-gle \
    --with-xpm \
    --with-jpeg 
  make 
}

do_package() {
  install -d ${CACHE_PATH}/etc/pam.d
  make install_prefix=${CACHE_PATH} install 
  
  install -D -m644 ../LICENSE ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE 
  chmod 755 ${CACHE_PATH}/usr/bin/xscreensaver 
  echo "NotShowIn=KDE;GNOME;" >> ${CACHE_PATH}/usr/share/applications/xscreensaver-properties.desktop 
}
