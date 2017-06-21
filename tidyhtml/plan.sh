pkg_origin=cosmos

pkg_name=tidyhtml
_pkg_name=tidy-html5
pkg_version=5.4.0
pkg_description="A tool to tidy down your HTML code to a clean style"
pkg_upstream_url="http://www.html-tidy.org/"
pkg_license=('custom')
pkg_deps=('glibc')
pkg_build_deps=('cmake' 'git')
pkg_source=("https://github.com/htacg/tidy-html5/releases/download/${pkg_version}/${_pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('7e121e1da7e21dc47610b87aae4b4f65')

do_build() {
  mkdir -p build
  
  cmake ../${_pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr 
  make 
}

do_package() {
  make DESTDIR=$CACHE_PATH install
  
  install -Dm644 $CACHE_PATH/${_pkg_name}-${pkg_version}/README/LICENSE.md ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE.md
}
