pkg_origin=cosmos

pkg_name=texlive-latexextra
pkg_version=2016.41473
_revnr=${pkg_version#2016.}
pkg_description="TeX Live - Large collection of add-on packages for LaTeX"
pkg_license=('GPL')
pkg_deps=('texlive-core')
groups=('texlive-most')
pkg_upstream_url='http://tug.org/texlive/'
# full credit for this PKGBUILD goes to Rémy Oudompheng <remy@archlinux.org>
pkg_source=("https://sources.archlinux.org/other/texlive/$pkg_name-$pkg_version-src.zip"
        "$pkg_name.maps")
pkg_shasum=('04e9310f60d2936ce08747dba24ceadc'
         '017fc9ed83747aa8884ca9ae0767531f')

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
   install -m644 $pkg_name.maps $CACHE_PATH/var/lib/texmf/arch/installedpkgs/
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

   #add symlinks that were in texlive-bin:
    _linked_scripts="
authorindex/authorindex
exceltex/exceltex
glossaries/makeglossaries
glossaries/makeglossaries-lite.lua
pax/pdfannotextractor.pl
perltex/perltex.pl
pst-pdf/ps4pdf
splitindex/splitindex.pl
svn-multi/svn-multi.pl
vpe/vpe.pl
yplan/yplan
"
    install -m755 -d "$CACHE_PATH"/usr/bin
    for _script in ${_linked_scripts}; do
        _scriptbase=$(basename $_script)
        _scriptbase=${_scriptbase%.*}
        ln -s /usr/share/texmf-dist/scripts/${_script} ${CACHE_PATH}/usr/bin/${_scriptbase}
    done

    rm "$CACHE_PATH"/usr/share/texmf-dist/scripts/glossaries/makeglossaries.bat
    rm "$CACHE_PATH"/usr/share/texmf-dist/scripts/pst-pdf/ps4pdf.bat*
    rm "$CACHE_PATH"/usr/share/texmf-dist/scripts/shipunov/biokey2html.bat
}
