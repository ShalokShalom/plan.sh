pkg_origin=cosmos

pkg_name=texlive-core
pkg_version=2016.41843
_revnr=${pkg_version#2016.}
pkg_description="TeX Live core distribution"
pkg_license=('GPL')
pkg_deps=('texlive-bin' 'perl')
optpkg_deps=(
  'ruby:        for old ConTeXT MkII and epspdf'
  'tk:          for texdoctk'
  'python2:     for dviasm'
  'python3:     for pythontex'
  'ghostscript: for epstopdf, epspdf and other ConTeXt tools' 
  'psutils:     to manipulate the output of dvips'
  't1utils:     can be useful when installing Type1 fonts'
)
groups=('texlive-most')
pkg_upstream_url='http://tug.org/texlive/'
# full credit for this PKGBUILD goes to Rémy Oudompheng <remy@archlinux.org>
pkg_source=("https://sources.archlinux.org/other/texlive/$pkg_name-$pkg_version-src.zip"
        "$pkg_name.maps"
        'texmf.cnf'
        'texmfcnf.lua'
        '09-texlive-fonts.conf')
install=texlive.install
pkg_shasum=('84c8d40322b98dc10994f8e378d62640'
         '54a34f8ddbeccec2427e4d5763349f9b'
         'c59f1074a749056b53d36a5892a47e1a'
         '16ad4dc53deb00029baef1b01ba1d984'
         '393a4bf67adc7ca5df2b386759d1a637')

do_build() {

   echo -n "   --> extracting all packages... "
   for p in *.tar.xz; do 
     bsdtar -xf $p
   done
   echo "done"

   rm -rf source doc
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

   find texmf-dist -type d -exec install -d -m755 $CACHE_PATH/usr/share/'{}' \;
   find texmf-dist -type f -exec install -m644 '{}' $CACHE_PATH/usr/share/'{}' \;
   find texmf-dist -type f -executable -exec chmod 755 $CACHE_PATH/usr/share/'{}' \;
 
   #############################################################
   ### install texmf tree
   echo "--> installing the /etc/texmf tree"
   install -d -m755 "$CACHE_PATH"/etc/texmf/web2c
   install -d -m755 "$CACHE_PATH"/etc/texmf/chktex
   install -d -m755 "$CACHE_PATH"/etc/texmf/dvips/config
   install -d -m755 "$CACHE_PATH"/etc/texmf/dvipdfmx
   install -d -m755 "$CACHE_PATH"/etc/texmf/tex/generic/config
   install -d -m755 "$CACHE_PATH"/etc/texmf/tex/generic/tex-ini-files
   install -d -m755 "$CACHE_PATH"/etc/texmf/ttf2pk
   install -d -m755 "$CACHE_PATH"/etc/texmf/xdvi
   install -d -m755 "$CACHE_PATH"/etc/fonts/conf.avail
   install -m644 "$CACHE_PATH"/09-texlive-fonts.conf "$CACHE_PATH"/etc/fonts/conf.avail/

   # Remove manpages (already in texlive-bin).
   rm -rf "$CACHE_PATH"/usr/share/texmf-dist/doc/man
   
   # Remove aleph from fmtutil.cnf
   sed -i -e '/aleph/d' "$CACHE_PATH"/usr/share/texmf-dist/web2c/fmtutil.cnf

   # copy config files to $TEXMFCONFIG tree
   cp -a "$CACHE_PATH"/usr/share/texmf-dist/chktex/chktexrc \
     	"$CACHE_PATH"/etc/texmf/chktex/
   cp -a "$CACHE_PATH"/usr/share/texmf-dist/web2c/mktex.cnf \
   	  "$CACHE_PATH"/etc/texmf/web2c/
   cp -a "$CACHE_PATH"/usr/share/texmf-dist/web2c/updmap-hdr.cfg \
   	  "$CACHE_PATH"/etc/texmf/web2c/
   cp -a "$CACHE_PATH"/usr/share/texmf-dist/web2c/fmtutil.cnf \
   	  "$CACHE_PATH"/etc/texmf/web2c/
   cp -a "$CACHE_PATH"/usr/share/texmf-dist/dvips/config/config.ps \
   	  "$CACHE_PATH"/etc/texmf/dvips/config/
   cp -a "$CACHE_PATH"/usr/share/texmf-dist/dvipdfmx/dvipdfmx.cfg \
   	  "$CACHE_PATH"/etc/texmf/dvipdfmx/
   cp -a "$CACHE_PATH"/usr/share/texmf-dist/tex/generic/tex-ini-files/pdftexconfig.tex \
   	  "$CACHE_PATH"/etc/texmf/tex/generic/tex-ini-files/
   cp -a "$CACHE_PATH"/usr/share/texmf-dist/tex/generic/config/language.dat \
   	  "$CACHE_PATH"/etc/texmf/tex/generic/config/
   cp -a "$CACHE_PATH"/usr/share/texmf-dist/tex/generic/config/language.def \
   	  "$CACHE_PATH"/etc/texmf/tex/generic/config/
   cp -a "$CACHE_PATH"/usr/share/texmf-dist/ttf2pk/ttf2pk.cfg \
   	  "$CACHE_PATH"/etc/texmf/ttf2pk/
   cp -a "$CACHE_PATH"/usr/share/texmf-dist/xdvi/XDvi \
   	  "$CACHE_PATH"/etc/texmf/xdvi/
   # remove TL specific warnings in the language.{dat,def} files:
   sed -i -e '/DO NOT EDIT/,+3 d' "$CACHE_PATH"/etc/texmf/tex/generic/config/language.*

   # replace upstream texmf.cnf
   rm -f "$CACHE_PATH"/usr/share/texmf-dist/web2c/texmf.cnf
   install -m644 "$CACHE_PATH"/texmf.cnf "$CACHE_PATH"/etc/texmf/web2c/texmf.cnf
   # since the location of texmf.cnf is hard-wired to be under /usr/share/texmf/web2c
   # make a symlink from /etc/texmf/web2c/texmf.cnf to the latter
   ln -sf /etc/texmf/web2c/texmf.cnf "$CACHE_PATH"/usr/share/texmf-dist/web2c/texmf.cnf
   # replace upstream texmfcnf.lua
   install -m644 "$CACHE_PATH"/texmfcnf.lua "$CACHE_PATH"/usr/share/texmf-dist/web2c/texmfcnf.lua

   # create symlinks for formats 
   echo "--> Create symlinks for TeX formats ..."
   mkdir -p "${CACHE_PATH}/usr/bin"
   bash "${CACHE_PATH}"/usr/share/texmf-dist/scripts/texlive/texlinks.sh -f "$CACHE_PATH"/usr/share/texmf-dist/web2c/fmtutil.cnf "$CACHE_PATH"/usr/bin/

   # install Perl libraries
   mv "$CACHE_PATH"/usr/share/texmf-dist/tlpkg "$CACHE_PATH"/usr/share
   rm -rf "$CACHE_PATH"/usr/share/tlpkg/tlpobj
   
   # copy config file to texmf-config
   #mkdir -p $CACHE_PATH/etc/texmf/tex/context/config
   #cp -a $CACHE_PATH/usr/share/texmf-dist/tex/context/config/cont-usr.tex \
   #	  $CACHE_PATH/etc/texmf/tex/context/config/cont-usr.tex
   
   # remove upstream updmap.cfg: it contains too many maps.
   rm "${CACHE_PATH}/usr/share/texmf-dist/web2c/updmap.cfg"
 
   # more cleanup
   rm -rf $CACHE_PATH/usr/share/texmf-dist/scripts/context/stubs/mswin/

    # link programs from /usr/share/texmf-dist/scripts
    _linked_scripts="
a2ping/a2ping.pl
accfonts/mkt1font
accfonts/vpl2ovp
accfonts/vpl2vpl
adhocfilelist/adhocfilelist.sh
arara/arara.sh
bundledoc/arlatex
bundledoc/bundledoc
checkcites/checkcites.lua
checklistings/checklistings.sh
chktex/chkweb.sh
chktex/deweb.pl
cjk-gs-integrate/cjk-gs-integrate.pl
context/perl/mptopdf.pl
context/stubs/unix/context
context/stubs/unix/contextjit
context/stubs/unix/luatools
context/stubs/unix/mtxrun
context/stubs/unix/mtxrunjit
context/stubs/unix/texexec
context/stubs/unix/texmfstart
ctanify/ctanify
ctanupload/ctanupload.pl
de-macro/de-macro
dosepsbin/dosepsbin.pl
dtxgen/dtxgen
dviasm/dviasm.py
epstopdf/epstopdf.pl
findhyph/findhyph
fontools/afm2afm
fontools/autoinst
fontools/ot2kpx
fragmaster/fragmaster.pl
installfont/installfont-tl
latex-git-log/latex-git-log
latex2man/latex2man
latexdiff/latexdiff-vc.pl
latexdiff/latexdiff.pl
latexdiff/latexrevise.pl
latexfileversion/latexfileversion
latexindent/latexindent.pl
latexmk/latexmk.pl
latexpand/latexpand
ltxfileinfo/ltxfileinfo
ltximg/ltximg.pl
lua2dox/lua2dox_filter
luaotfload/luaotfload-tool.lua
make4ht/make4ht
match_parens/match_parens
mf2pt1/mf2pt1.pl
mkjobtexmf/mkjobtexmf.pl
oberdiek/pdfatfi.pl
pdfbook2/pdfbook2
pdfcrop/pdfcrop.pl
pdfjam/pdf180
pdfjam/pdf270
pdfjam/pdf90
pdfjam/pdfbook
pdfjam/pdfflip
pdfjam/pdfjam
pdfjam/pdfjam-pocketmod
pdfjam/pdfjam-slides3up
pdfjam/pdfjam-slides6up
pdfjam/pdfjoin
pdfjam/pdfnup
pdfjam/pdfpun
pdfxup/pdfxup
pfarrei/a5toa4.tlu
pfarrei/pfarrei.tlu
pkfix-helper/pkfix-helper
pkfix/pkfix.pl
ps2eps/ps2eps.pl
purifyeps/purifyeps
pythontex/pythontex.py
pythontex/depythontex.py
simpdftex/simpdftex
srcredact/srcredact.pl
sty2dtx/sty2dtx.pl
texcount/texcount.pl
tex4ebook/tex4ebook
texdef/texdef.pl
texdiff/texdiff
texdirflatten/texdirflatten
texdoc/texdoc.tlu
texdoctk/texdoctk.pl
texfot/texfot.pl
texlive/allcm.sh
texlive/allneeded.sh
texlive/dvi2fax.sh
texlive/dvired.sh
texlive/e2pall.pl
texlive/fmtutil-sys.sh
texlive/fmtutil.pl
texlive/fontinst.sh
texlive/kpsetool.sh
texlive/kpsewhere.sh
texlive/ps2frag.sh
texlive/pslatex.sh
texlive/rungs.tlu
texlive/texconfig-dialog.sh
texlive/texconfig-sys.sh
texlive/texconfig.sh
texlive/texlinks.sh
texlive/updmap-sys.sh
texlive/updmap.pl
texliveonfly/texliveonfly.py
texloganalyser/texloganalyser
thumbpdf/thumbpdf.pl
typeoutfileinfo/typeoutfileinfo.sh
xindy/texindy.pl
xindy/xindy.pl
"
    install -m755 -d $CACHE_PATH/usr/bin
    for _script in ${_linked_scripts}; do
        _scriptbase=$(basename $_script)
        _scriptbase=${_scriptbase%.*}
        ln -s /usr/share/texmf-dist/scripts/${_script} ${CACHE_PATH}/usr/bin/${_scriptbase}
    done
    ln -s /usr/share/texmf-dist/scripts/listings-ext/listings-ext.sh ${CACHE_PATH}/usr/bin/listings-ext.sh

    # additional symlinks
    ln -s allcm ${CACHE_PATH}/usr/bin/allec
    ln -s fmtutil ${CACHE_PATH}/usr/bin/mktexfmt
    ln -s kpsetool ${CACHE_PATH}/usr/bin/kpsexpand
    ln -s kpsetool ${CACHE_PATH}/usr/bin/kpsepath
    ln -s epstopdf ${CACHE_PATH}/usr/bin/repstopdf
    ln -s pdfcrop ${CACHE_PATH}/usr/bin/rpdfcrop
    ln -s luaotfload-tool ${CACHE_PATH}/usr/bin/mkluatexfontdb
}
