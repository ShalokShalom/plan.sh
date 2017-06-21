pkg_origin=cosmos

pkg_name=xine-lib
pkg_version=1.2.6
pkg_description="A multimedia playback engine"
pkg_upstream_url="http://www.xine-project.org"
pkg_license=('LGPL' 'GPL')
pkg_deps=('libxvmc' 'ffmpeg' 'libxinerama' 'pulseaudio' 'mesa')
pkg_build_deps=('wavpack' 'faad2' 'libmng' 'imagemagick' 'libmodplug'
             'vcdimager' 'jack' 'aalib' 'libdca' 'a52dec' 'libmad'
             'libmpcdec' 'libcaca' 'libbluray' 'libvdpau' 'glu')
optpkg_deps=('imagemagick: for using the imagemagick plugin' \
            'jack: for using the jack plugin' \
            'vcdimager: for using the vcd plugin' \
            'wavpack: for using the wavpack plugin' \
            'faad2: for using the faad plugin' \
            'libmng: for using the mng plugin' \
            'aalib: for using the aalib plugin' \
            'libmodplug: for using the modplug plugin' \
            'libdca: for using the dca plugin' \
            'a52dec: for using the a52 plugin' \
            'libmad: for using the mp3 plugin' \
            'libmpcdec: for using the musepack plugin' \
            'libcaca: for using the caca plugin' \
            'libbluray: for using the bluray plugin' \
            'libvdpau: for using the VDPAU plugin')
pkg_source=("http://downloads.sourceforge.net/sourceforge/xine/${pkg_name}-${pkg_version}.tar.xz"
        'accel_vaapi.h')
pkg_shasum=('02ee3c2380273989b4b016903209e05e'
         'eba8ea7de59c0d5a25e475bbd129341d')

do_build() {
  #cp accel_vaapi.h ${pkg_name}-${pkg_version}/src/xine-engine/
  
  ./configure --prefix=/usr \
              --with-wavpack \
              --enable-vdpau \
              --disable-optimizations \
              --disable-gnomevfs
  make
}

do_package() {
  
  make DESTDIR=${CACHE_PATH} install
}

