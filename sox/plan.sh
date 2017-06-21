pkg_origin=cosmos

pkg_name=sox
pkg_version=14.4.2
pkg_description="The Swiss Army knife of sound processing tools"
pkg_upstream_url="http://sox.sourceforge.net/"
pkg_license=('GPL' 'LGPL')
pkg_deps=('libltdl' 'file' 'libsndfile' 'libpng' 'lame' 'opencore-amr' 'gsm' 'pulseaudio')
pkg_build_deps=('libao' 'libmad' 'libid3tag' 'wavpack')
optpkg_deps=('libao: for ao plugin'
            'libmad: for mp3 plugin'
            'libid3tag: for mp3 plugin'
            'wavpack: for wavpack plugin')
pkg_source=("http://downloads.sourceforge.net/sox/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('ba804bb1ce5c71dd484a102a5b27d0dd')

do_build() {
  sed -i 's/(sox_.*|lsx_(check_read_params|/(sox_.*|lsx_(error|flush|check_read_params|/' src/Makefile.am
  
  aclocal
  automake
  
  ./configure --prefix=/usr \
    --sysconfdir=/etc \
    --with-dyn-default \
    --with-distro="KaOS" 
  make 
}

do_package() {
  
  make DESTDIR="${CACHE_PATH}" install
}
