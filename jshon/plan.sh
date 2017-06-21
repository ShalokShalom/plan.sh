pkg_origin=cosmos

pkg_name=jshon
pkg_version=20131105
pkg_description="A json parser for the shell."
pkg_upstream_url="http://kmkeen.com/jshon/"
pkg_license=('MIT')
pkg_deps=('jansson')
pkg_source=("http://kmkeen.com/$pkg_name/$pkg_name-$pkg_version.tar.gz")
pkg_shasum=('84596bcf2d6cde7bbc0fcb4626765b99')

do_build() {
  
  make
}

do_package() {
  
  install -Dm755 $pkg_name "$pkg_prefix/usr/bin/$pkg_name"
  install -Dm644 $pkg_name.1 "$pkg_prefix/usr/share/man/man1/$pkg_name.1"
  install -Dm644 LICENSE "$pkg_prefix/usr/share/licenses/$pkg_name/LICENSE"
}
