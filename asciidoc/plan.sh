pkg_origin=cosmos
 
pkg_name=asciidoc
pkg_version=8.6.9
pkg_description='Text document format for short documents, articles, books and UNIX man pages.'
pkg_upstream_url='http://www.methods.co.nz/asciidoc/'
pkg_license=('GPL')
pkg_deps=('python2' 'libxslt' 'docbook-xsl')
optpkg_deps=('lilypond: music-filter'
            'imagemagick: music-filter (used in conjunction with lilypond)'
            'source-highlight: source-highlight-filter'
            'dblatex: pdf generation'
            'lynx: text generation'
            'w3m: text generation (alternative to lynx)')
pkg_source=("http://sourceforge.net/projects/asciidoc/files/asciidoc/${pkg_version}/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('c59018f105be8d022714b826b0be130a')

do_build() {
  cd ${pkg_name}-${pkg_version}

  ./configure \
    --prefix=/usr \
    --sysconfdir=/etc
}

do_package() {
  cd ${pkg_name}-${pkg_version}

  make install DESTDIR=${pkg_prefix}

  install -Dm644 asciidocapi.py ${pkg_prefix}/usr/lib/python2.7/site-packages/asciidocapi.py
  install -Dm644 vim/syntax/asciidoc.vim ${pkg_prefix}/usr/share/vim/vimfiles/syntax/asciidoc.vim
}
