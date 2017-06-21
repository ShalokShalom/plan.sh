pkg_origin=cosmos

pkg_name=djvulibre
pkg_version=3.5.27
_pkg_version=3969bdfd2c904895ce091913feb7e91b2eca54ae
pkg_description="Suite to create, manipulate and view DjVu ('déjà vu') documents"
pkg_license=('GPL')
pkg_upstream_url="http://djvu.sourceforge.net/"
pkg_deps=('gcc-libs' 'libtiff' 'bash' 'hicolor-icon-theme')
pkg_build_deps=('librsvg')
pkg_source=("http://downloads.sourceforge.net/djvu/${pkg_name}-${pkg_version}.tar.gz")
#pkg_source=("http://sourceforge.net/code-snapshots/git/d/dj/djvu/djvulibre-git.git/djvu-djvulibre-git-3969bdfd2c904895ce091913feb7e91b2eca54ae.zip")
pkg_shasum=('aa4ed331f669f5a72e3c0d7f9196c4e6')

do_build() {
  
  ./autogen.sh
  ./configure --prefix=/usr --disable-desktopfiles
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install

  #Install icons for mime-types.
  install -m755 -d ${pkg_prefix}/usr/share/icons/hicolor/{22x22,32x32,48x48,64x64}/mimetypes
  for sz in 22 32 48 64; do
    install -m644 desktopfiles/prebuilt-hi${sz}-djvu.png ${pkg_prefix}/usr/share/icons/hicolor/${sz}x${sz}/mimetypes/image-vnd.djvu.mime.png
  done
}
