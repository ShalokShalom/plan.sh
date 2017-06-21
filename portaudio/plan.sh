pkg_origin=cosmos

pkg_name=portaudio
pkg_version=19.2
_pkg_version=190600_20161030
pkg_description="PortAudio is a free, cross platform, open-source, audio I/O library."
pkg_upstream_url="http://www.portaudio.com"
pkg_license="custom"
pkg_deps=('jack')
pkg_source=("http://www.portaudio.com/archives/pa_stable_v${_pkg_version}.tgz")
pkg_shasum=('4df8224e047529ca9ad42f0521bf81a8')

do_build() {

  ./configure --prefix=/usr \
    --with-alsa \
    --with-jack \
    --enable-cxx \
    --enable-static=no
  make -j1
}

do_package() {
  make DESTDIR=$pkg_prefix install
  
  install -D -m644 LICENSE.txt ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE.txt
}
