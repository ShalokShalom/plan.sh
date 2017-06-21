pkg_origin=cosmos

# NOTE: Disabled the gtk2 module so no gtk-preview

pkg_name=mlt
pkg_version=6.4.1
pkg_description="An open source multimedia framework"
pkg_upstream_url="http://www.mltframework.org"
pkg_license=('GPL')
pkg_deps=('sdl_image' 'libsamplerate' 'libdv' 'sox' 'libxml2' 'ffmpeg' 'python2' 'jack' 'ladspa' 'qt5-svg'
         'frei0r-plugins' 'libexif')
pkg_build_deps=('swig')
#pkg_source=("http://downloads.sourceforge.net/sourceforge/mlt/$pkg_name-$pkg_version.tar.gz")
pkg_source=("https://github.com/mltframework/mlt/archive/v$pkg_version.tar.gz")
pkg_shasum=('e9f0584739369c40b8f91f8cf50ea3ea')

do_build() {
  
  CXXFLAGS="-std=c++11"

  ./configure --prefix=/usr \
              --enable-gpl \
              --enable-gpl3 \
              --qimage-libdir=/usr/lib/ \
              --qt-includedir=/usr/include/qt \
              --disable-gtk2 \
              --avformat-swscale  
  make

  # mlt python bindings
  ./build
}

package () {
  make DESTDIR=${pkg_prefix} install
  
  # install python bindings
  mkdir -p ${pkg_prefix}/usr/lib/python2.7/
  install -m0755 mlt.py ${pkg_prefix}/usr/lib/python2.7/
  install -m0755 _mlt.so ${pkg_prefix}/usr/lib/python2.7/
  install -m0755 mlt_wrap.o ${pkg_prefix}/usr/lib/python2.7/
}
