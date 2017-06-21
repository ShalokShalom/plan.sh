pkg_origin=
 
pkg_name=simplescreenrecorder
pkg_version=0.3.8
_commit=65975c6
pkg_description="Screen recorder that is actually quite complex, but 'simple' in the sense that it's easy to use"
pkg_upstream_url="http://www.maartenbaert.be/simplescreenrecorder/"
pkg_license=("GPL3")
pkg_deps=('qt5-x11extras' 'ffmpeg' 'alsa-lib' 'pulseaudio' 'jack' 'libgl' 'glu' 'libx11' 'libxext' 
         'libxfixes' 'libxi')
pkg_build_deps=('qt5-tools')
pkg_source=("https://github.com/MaartenBaert/ssr/archive/$pkg_version.tar.gz")
pkg_shasum=('722eda8b3af5137f2f173a8492fb2cf1')

do_build() {
  cd ssr-$pkg_version
  
  export CPPFLAGS="-fPIC"
  
  ./configure --prefix=/usr --disable-assert --with-qt5=yes 
  make
}
do_package() {
  cd ssr-$pkg_version
  
  make DESTDIR=$pkg_prefix install
}
