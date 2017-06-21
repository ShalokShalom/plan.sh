pkg_origin=

pkg_name=link-grammar
pkg_version=5.3.7
pkg_description="Syntactic parser, based on link grammar, an original theory of English syntax."
pkg_upstream_url="http://www.abisource.com/projects/link-grammar/"
pkg_license=('BSD')
pkg_deps=('aspell')
pkg_source=("http://www.abisource.com/downloads/${pkg_name}/${pkg_version}/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('d0567e53bad87a8b669dcaab4c7c109a')

do_build() {
  cd ${pkg_name}-${pkg_version}

  ./configure --prefix=/usr
  make
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  make DESTDIR=${pkg_prefix} install

  install -Dm644 LICENSE ${pkg_prefix}/usr/share/licenses/link-grammar/LICENSE
}
