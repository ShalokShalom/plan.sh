pkg_origin=cosmos

pkg_name=alure
pkg_version=1.2
pkg_description="Utility library to help manage common tasks with OpenAL applications."
pkg_upstream_url="http://kcat.strangesoft.net/alure.html"
pkg_license=('MIT')
pkg_deps=('openal' 'libsndfile' 'libvorbis' 'flac' 'mpg123')
pkg_build_deps=('cmake')
pkg_source=("http://kcat.strangesoft.net/alure-releases/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('3088aba074ad02d95ea51e705053b9f5')

do_build() {

  cmake . -DCMAKE_INSTALL_PREFIX=/usr 
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install

  install -Dm0644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/COPYING
} 
