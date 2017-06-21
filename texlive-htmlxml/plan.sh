pkg_origin=cosmos

pkg_name=texlive-htmlxml
pkg_version=2012.24013
_revnr=${pkg_version#2011.}
pkg_description="TeX Live - Packages to convert LaTeX to XML/HTML, and typeset XML/SGML"
pkg_license=('GPL')
pkg_deps=('texlive-core')
groups=('texlive-most')
pkg_upstream_url='http://tug.org/texlive/'
pkg_source=("ftp://ftp.archlinux.org/other/texlive/$pkg_name-$pkg_version-src.zip")
install=texlive.install
pkg_shasum=('1e468991ffadc7a36f9cc6ed01b83fcb')

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
   ln -s /usr/share/texmf-dist/scripts/tex4ht/ht.sh $CACHE_PATH/usr/bin/ht
   ln -s /usr/share/texmf-dist/scripts/tex4ht/htcontext.sh $CACHE_PATH/usr/bin/htcontext
   ln -s /usr/share/texmf-dist/scripts/tex4ht/htlatex.sh $CACHE_PATH/usr/bin/htlatex
   ln -s /usr/share/texmf-dist/scripts/tex4ht/htmex.sh $CACHE_PATH/usr/bin/htmex
   ln -s /usr/share/texmf-dist/scripts/tex4ht/httex.sh $CACHE_PATH/usr/bin/httex
   ln -s /usr/share/texmf-dist/scripts/tex4ht/httexi.sh $CACHE_PATH/usr/bin/httexi
   ln -s /usr/share/texmf-dist/scripts/tex4ht/htxelatex.sh $CACHE_PATH/usr/bin/htxelatex
   ln -s /usr/share/texmf-dist/scripts/tex4ht/htxetex.sh $CACHE_PATH/usr/bin/htxetex
   ln -s /usr/share/texmf-dist/scripts/tex4ht/mk4ht.pl $CACHE_PATH/usr/bin/mk4ht
}
