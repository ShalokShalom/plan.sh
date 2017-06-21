pkg_origin=cosmos

pkgbase=hspell
pkg_name=('hspell' 'hunspell-he')
pkg_version=1.3
pkg_license=('GPL')
pkg_upstream_url="http://www.ivrix.org.il/projects/spell-checker/"
pkg_build_deps=('glibc' 'zlib' 'perl' 'hunspell' 'gawk')
pkg_source=("http://hspell.ivrix.org.il/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('351850c9f6974a709dd092a2d1063e4a')

do_build() {
  
  ./configure --prefix=/usr \
        --mandir=/usr/share/man \
        --enable-linginfo \
        --enable-fatverb \
        --enable-shared
  make 
  make hunspell
}

package_hspell() {
  pkg_description="Hebrew spell-checker"
  pkg_deps=('glibc' 'zlib' 'perl')

  make DESTDIR=${pkg_prefix} install

  rm -f ${pkg_prefix}/usr/lib/libhspell.a
}

package_hunspell-he() {
  pkg_description="Hebrew hunspell dictionary"
  

  install -dm755 ${pkg_prefix}/usr/share/hunspell
  install -m644 he.dic ${pkg_prefix}/usr/share/hunspell/he_IL.dic
  install -m644 he.aff ${pkg_prefix}/usr/share/hunspell/he_IL.aff

  install -dm755 ${pkg_prefix}/usr/share/myspell/dicts
  pushd $pkg_prefix/usr/share/myspell/dicts
    for file in $pkg_prefix/usr/share/hunspell/*; do
      ln -sv /usr/share/hunspell/$(basename $file) .
    done
  popd
}
