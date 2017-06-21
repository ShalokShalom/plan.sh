pkg_origin=cosmos

pkg_name=ebook-tools
pkg_version=0.2.2
pkg_description="Tools for accessing and converting various ebook file formats"
pkg_upstream_url="http://sourceforge.net/projects/ebook-tools"
pkg_license=('custom')
pkg_deps=('libzip' 'libxml2')
pkg_build_deps=('pkgconfig' 'cmake' 'doxygen')
pkg_source=("http://downloads.sourceforge.net/sourceforge/ebook-tools/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('67bce67ceb72dcc3578d6a81ef92b29b')

do_build() {
  mkdir build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install

  install -Dm644 ${CACHE_PATH}/${pkg_name}-${pkg_version}/LICENSE ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
