pkg_origin=

pkg_name=js
pkg_version=17.0.0
pkg_description="JavaScript interpreter and libraries"
pkg_upstream_url="https://developer.mozilla.org/en-US/docs/Mozilla/Projects/SpiderMonkey/Releases/17"
pkg_license=('GPL2')
pkg_deps=('nspr' 'gcc-libs' 'libffi' 'readline')
pkg_build_deps=('python2' 'zip')
pkg_source=("https://ftp.mozilla.org/pub/mozilla.org/js/mozjs${pkg_version}.tar.gz")
pkg_shasum=('20b6f8f1140ef6e47daa3b16965c9202')

do_build() {
  cd mozjs${pkg_version}/js/src
  # http://www.linuxfromscratch.org/blfs/view/svn/general/JS2.html needed for newer perl
  sed -i 's/(defined\((@TEMPLATE_FILE)\))/\1/' config/milestone.pl

  unset CPPFLAGS

  ./configure --prefix=/usr \
       --with-system-nspr \
       --enable-threadsafe \
       --with-system-libffi \
       --enable-readline

  make
}

do_package() {
  cd mozjs${pkg_version}/js/src
  make DESTDIR=${pkg_prefix} install

  find ${pkg_prefix}/usr/{lib/pkgconfig,include} -type f -exec chmod -x {} +
}

