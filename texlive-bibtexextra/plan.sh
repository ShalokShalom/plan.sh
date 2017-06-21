pkg_origin=cosmos

pkg_name=texlive-bibtexextra
pkg_version=2012.26868
_revnr=${pkg_version#2012.}
pkg_description="TeX Live - Additional BibTeX styles and bibliography databases"
pkg_license=('GPL')
pkg_deps=('texlive-core')
groups=('texlive-most')
pkg_upstream_url='http://tug.org/texlive/'
pkg_source=("ftp://ftp.archlinux.org/other/texlive/$pkg_name-$pkg_version-src.zip")
install=texlive.install
pkg_shasum=('6781ae49bf64b298037028d627bb4870')

do_build() {

   for p in *.tar.xz; do
	   bsdtar -xf $p
   done

   rm -rf {tlpkg,doc,source} || true
}

do_package() {
   install -m755 -d $CACHE_PATH/var/lib/texmf/arch/installedpkgs
   sed -i '/^#/d' CONTENTS
   install -m644 CONTENTS $CACHE_PATH/var/lib/texmf/arch/installedpkgs/${pkg_name}_${_revnr}.pkgs
   install -m755 -d $CACHE_PATH/usr/share

   wanteddirs=$(for d in *; do test -d $d && [[ $d != texmf* ]] && echo $d; done) || true
   for dir in $wanteddirs; do
     find $dir -type d -exec install -d -m755 $CACHE_PATH/usr/share/texmf-dist/'{}' \;
     find $dir -type f -exec install -m644 '{}' $CACHE_PATH/usr/share/texmf-dist/'{}' \;
   done

   if [[ -d texmf-dist ]]; then
     find texmf-dist -type d -exec install -d -m755 $CACHE_PATH/usr/share/'{}' \;
     find texmf-dist -type f -exec install -m644 '{}' $CACHE_PATH/usr/share/'{}' \;
   fi

   if [[ -d $CACHE_PATH/usr/share/texmf-dist/scripts ]]; then
     find $CACHE_PATH/usr/share/texmf-dist/scripts -type f -exec chmod a+x '{}' \;
   fi

   install -m755 -d $CACHE_PATH/usr/bin

   ln -s /usr/share/texmf-dist/scripts/bibexport/bibexport.sh $CACHE_PATH/usr/bin/bibexport
   ln -s /usr/share/texmf-dist/scripts/listbib/listbib $CACHE_PATH/usr/bin/listbib
   ln -s /usr/share/texmf-dist/scripts/urlbst/urlbst $CACHE_PATH/usr/bin/urlbst
}

