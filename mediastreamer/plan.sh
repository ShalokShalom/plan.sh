pkg_origin=

pkg_name=mediastreamer
pkg_version=2.12.0
pkg_description="A library written in C that allows you to create and run audio and video streams."
pkg_upstream_url="http://www.linphone.org"
pkg_license=('GPL')
pkg_deps=('ortp' 'speex' 'v4l-utils' 'ffmpeg' 'libxv' 'glew' 'libupnp')
pkg_build_deps=('cmake' 'intltool' 'vim')
pkg_source=("http://download-mirror.savannah.gnu.org/releases/linphone/mediastreamer/mediastreamer-$pkg_version.tar.gz")
pkg_shasum=('f4570034ce3875cf238e0e1249b5ec2e')

do_build() {

  cd "$CACHE_PATH"/$pkg_name-$pkg_version
  
  ./configure --prefix=/usr --disable-strict
  make
}

do_package() {
  cd "${CACHE_PATH}"/$pkg_name-$pkg_version
  
  make DESTDIR="${pkg_prefix}" install
}
