pkg_origin=cosmos

pkg_name=autopano-sift-c
pkg_version=2.5.1
pkg_description="Identify key feature points within arbitrary images"
pkg_upstream_url="http://hugin.sourceforge.net/"
pkg_license=('GPL2')
pkg_deps=('libxml2' 'libpano13>=2.9.17' 'gcc-libs')
pkg_build_deps=('cmake')
pkg_source=("http://sourceforge.net/projects/hugin/files/autopano-sift-C/autopano-sift-C-2.5.1/autopano-sift-C-${pkg_version}.tar.gz")
pkg_shasum=('b9bade07e8c4f2ea383c22a082c260e0')

do_build() {

  cmake -DCMAKE_INSTALL_PREFIX=/usr .
  sed -i 's/-lz/-lz -lm/' CMakeFiles/{autopano,generatekeys}.dir/link.txt
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
