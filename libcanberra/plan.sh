pkg_origin=cosmos

pkg_name=libcanberra
pkg_version=0.30
pkg_description="A small and lightweight implementation of the XDG Sound Theme Specification"
pkg_upstream_url="http://0pointer.de/lennart/projects/libcanberra"
pkg_license=('LGPL')
pkg_deps=('libvorbis' 'libtool' 'alsa-lib' 'tdb' 'sound-theme-freedesktop' 
         'pulseaudio' 'gstreamer')
pkg_source=("http://0pointer.de/lennart/projects/libcanberra/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('34cb7e4430afaf6f447c4ebdb9b42072')

do_build() {
  
    ./configure --sysconfdir=/etc \
        --prefix=/usr \
        --localstatedir=/var \
        --disable-static \
        --with-builtin=dso \
        --enable-null \
        --disable-oss \
        --enable-alsa \
        --enable-gstreamer \
        --enable-pulse \
        --disable-gtk \
        --with-systemdsystemunitdir=/usr/lib/systemd/system
  make
}

do_package() {
  make -j1 DESTDIR=${pkg_prefix} install
  
  rm -f ${pkg_prefix}/usr/lib/libcanberra-gtk.la
  rm -f ${pkg_prefix}/usr/lib/gtk-2.0/modules/*.la
}
