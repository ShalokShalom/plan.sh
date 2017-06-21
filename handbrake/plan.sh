pkg_origin=

pkg_name=handbrake
pkg_version=1.0.7
_commit=c069f98
pkg_description="Multithreaded video transcoder"
pkg_upstream_url="https://handbrake.fr/"
pkg_license=('GPL')
pkg_deps=('bzip2' 'gcc-libs' 'gst-plugins-base' 'libnotify' 'dbus-glib' 'fribidi' 'libass' 'gtk3'
         'fontconfig' 'freetype2' 'libxml2' 'libogg' 'libvorbis' 'libtheora' 'libsamplerate'
         'libgudev' 'x264' 'desktop-file-utils' 'hicolor-icon-theme' 'lame' 'jansson')
pkg_build_deps=('intltool' 'python2' 'yasm' 'wget')
pkg_source=("https://handbrake.fr/mirror/HandBrake-${pkg_version}.tar.bz2")
#pkg_source=("https://github.com/HandBrake/HandBrake/tarball/master/handbrake-${pkg_version}.tar.gz")
pkg_shasum=('bf39fcc56a82ccca32a9faac8fa633f5')

do_build() {
  cd HandBrake-${pkg_version}
  #cd HandBrake-HandBrake-${_commit}/

  ./configure --prefix=/usr
  cd build
  make
}

do_package() {
  cd HandBrake-${pkg_version}/build
  #cd HandBrake-HandBrake-${_commit}/build

  make DESTDIR=${pkg_prefix} install
}

