pkg_origin=

pkg_name=freshplayerplugin
pkg_version=0.3.7
pkg_description='ppapi2npapi compatibility layer.'
pkg_upstream_url='https://github.com/i-rinat/freshplayerplugin'
pkg_license=('MIT')
pkg_deps=('alsa-lib' 'ffmpeg' 'freetype2' 'gtk2' 'jack' 'libevent' 'libgl' 'v4l-utils' 
         'openssl' 'pango' 'pulseaudio' 'pepper-flash' 'icu')
pkg_build_deps=('cmake' 'ragel')
pkg_source=("https://github.com/i-rinat/freshplayerplugin/releases/download/v${pkg_version}/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('9076ce1e61c9ec12234306b62afff9ce')

do_build() {
  mkdir -p build
  cd build

  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DWITH_GTK=2 \
    -DWITH_PULSEAUDIO=1
  make
}

do_package() {
  cd build
  make DESTDIR=${pkg_prefix} install

  install -Dm644 ../${pkg_name}-${pkg_version}/data/freshwrapper.conf.example ${pkg_prefix}/usr/share/${pkg_name}/freshwrapper.conf.example
  install -Dm644 ../${pkg_name}-${pkg_version}/LICENSE ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
