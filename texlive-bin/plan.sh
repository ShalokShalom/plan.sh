pkg_origin=cosmos

pkg_name=texlive-bin
pkg_version=2016.41290
pkg_description="TeX Live binaries"
pkg_upstream_url='https://tug.org/texlive/'
pkg_license=('GPL')
pkg_deps=('t1lib' 'gd' 'poppler' 'libsigsegv' 'zziplib' 'libpng' 'libjpeg-turbo' 'freetype2'
         'cairo' 'pixman' 'graphite' 'icu' 'harfbuzz' 'libpaper')
pkg_build_deps=('perl' 'clisp' 'ffcall')
optpkg_deps=('ed: for texconfig')
install="texlive.install"
# full credit for this PKGBUILD goes to Rémy Oudompheng <remy@archlinux.org>
pkg_source=("https://mirrors.kernel.org/archlinux/other/texlive/texlive-bin-source-${pkg_version}.tar.xz"
        'mktexlsr.hook'
        'mktexlsr.script'
        'texlive-updmap.hook'
        'texlive-updmap.script')
pkg_shasum=('7303361f2d441eb5c962a996fd77e8fa'
         '7bc9cef52d3b0c15d2364b7d8658faa6'
         '2bbbef810687f4b2804a4b8cb91ce02f'
         'c18cbbd000aac60813b1695aa058964f'
         'c64d77b5111a26b9995263b49df4937c')

do_prepare() {
   #patch -p2 -i "$CACHE_PATH"/poppler0.26.patch
}

do_build() {

   # t4ht expects to be in /usr/share/texmf/bin/t4ht
   sed -i s/SELFAUTOPARENT/TEXMFROOT/ source/texk/tex4htk/t4ht.c
   #############################################################
   ### configure
   ## prevent compiling Xdvi with libXp
   sed -i~ 's|-lXp ||' texk/xdvik/configure
   test ! -d Work && mkdir Work
   echo "--> Initial configuration..."
   # we use temporary prefix to avoid messing the existing
   # $CACHE_PATH/usr/share/texmf tree
   ../configure --prefix=/usr -C \
     --sysconfdir=/etc \
     --datarootdir=/usr/share \
     --datadir=/usr/share \
     --mandir=/usr/share/man \
     --disable-native-texlive-build \
     --with-banner-add="/KaOS" \
     --disable-multiplatform \
     --disable-dialog \
     --disable-psutils \
     --disable-t1utils \
     --disable-bibtexu \
     --disable-xz \
     --enable-shared \
     --disable-static \
     --with-system-zlib \
     --with-system-zziplib \
     --with-system-pnglib \
     --with-system-ncurses \
     --with-system-t1lib \
     --with-system-gd \
     --with-system-poppler \
     --with-system-xpdf \
     --with-system-freetype2 \
     --with-system-pixman \
     --with-system-cairo \
     --with-system-harfbuzz \
     --with-system-icu \
     --with-system-gmp \
     --with-system-mpfr \
     --with-system-libpaper \
     --with-system-graphite \
     --with-freetype2-libdir=/usr/lib \
     --with-freetype2-include=/usr/include/freetype2 \
     --with-xdvi-x-toolkit=xaw \
     --disable-dump-share \
     --disable-aleph \
     --enable-luatex \
     --with-clisp-runtime=default \
     --enable-xindy --disable-xindy-rules --disable-xindy-docs
   #############################################################
   ### make
   echo "-------------------------------------------------------"
   echo "--> Building the whole beast ..."
   echo "-------------------------------------------------------"
   make
}

do_package() {

   #############################################################
   ### install
   # fixes for xindy
   find utils/xindy -name Makefile -exec sed -i -e "s|^prefix =.\+$|prefix = $CACHE_PATH/usr|" -e "s|^mandir =.\+$|mandir = \${prefix}/share/man|" -e "s|^datadir =.\+$|datadir = \${datarootdir}/texmf|" -e "s|^docdir =.\+$|docdir = \${datadir}/doc/xindy|" '{}' \;

   echo "-------------------------------------------------------"
   echo "--> Proceeding with make install ..."
   echo "-------------------------------------------------------"
   make DESTDIR="${CACHE_PATH}" texmf="$CACHE_PATH"/usr/share/texmf install
   rm -rf "${CACHE_PATH}"/usr/{texmf,share/texmf-dist}

   ## symlink engines by hand. texlinks has moved to texlive-core...
   mkdir -p ${CACHE_PATH}/usr/bin
   ln -s eptex ${CACHE_PATH}/usr/bin/platex
   ln -s euptex ${CACHE_PATH}/usr/bin/uplatex
   ln -s luatex ${CACHE_PATH}/usr/bin/dvilualatex
   ln -s luatex ${CACHE_PATH}/usr/bin/dviluatex
   ln -s luatex ${CACHE_PATH}/usr/bin/lualatex
   ln -s pdftex ${CACHE_PATH}/usr/bin/amstex
   ln -s pdftex ${CACHE_PATH}/usr/bin/cslatex
   ln -s pdftex ${CACHE_PATH}/usr/bin/csplain
   ln -s pdftex ${CACHE_PATH}/usr/bin/eplain
   ln -s pdftex ${CACHE_PATH}/usr/bin/etex
   ln -s pdftex ${CACHE_PATH}/usr/bin/jadetex
   ln -s pdftex ${CACHE_PATH}/usr/bin/latex
   ln -s tex ${CACHE_PATH}/usr/bin/lollipop
   ln -s pdftex ${CACHE_PATH}/usr/bin/mex
   ln -s pdftex ${CACHE_PATH}/usr/bin/mllatex
   ln -s pdftex ${CACHE_PATH}/usr/bin/mltex
   ln -s pdftex ${CACHE_PATH}/usr/bin/pdfetex
   ln -s pdftex ${CACHE_PATH}/usr/bin/pdfcslatex
   ln -s pdftex ${CACHE_PATH}/usr/bin/pdfcsplain
   ln -s pdftex ${CACHE_PATH}/usr/bin/pdfjadetex
   ln -s pdftex ${CACHE_PATH}/usr/bin/pdflatex
   ln -s pdftex ${CACHE_PATH}/usr/bin/pdfmex
   ln -s pdftex ${CACHE_PATH}/usr/bin/pdfxmltex
   ln -s pdftex ${CACHE_PATH}/usr/bin/texsis
   ln -s pdftex ${CACHE_PATH}/usr/bin/utf8mex
   ln -s pdftex ${CACHE_PATH}/usr/bin/xmltex
   ln -s xetex ${CACHE_PATH}/usr/bin/xelatex

   ## install pacman hooks
   install -D -m644 ${CACHE_PATH}/mktexlsr.hook "$CACHE_PATH/usr/share/libalpm/hooks/mktexlsr.hook"
   install -D -m644 ${CACHE_PATH}/texlive-updmap.hook "$CACHE_PATH/usr/share/libalpm/hooks/texlive-updmap.hook"
   install -D -m755 ${CACHE_PATH}/mktexlsr.script "$CACHE_PATH/usr/share/libalpm/scripts/mktexlsr"
   install -D -m755 ${CACHE_PATH}/texlive-updmap.script "$CACHE_PATH/usr/share/libalpm/scripts/texlive-updmap"

   #############################################################
   # remove dangling symlinks
   _bibtexextra_scripts="
bibexport
bibdoiadd
bibzbladd
listbib
ltx2crossrefxml
multibibliography
urlbst
"
   _core_scripts="
a2ping
a5toa4
adhocfilelist
afm2afm
allcm
allec
allneeded
arara
arlatex
autoinst
bundledoc
checkcites
checklistings
chkweb
cjk-gs-integrate
context
contextjit
ctanify
ctanupload
de-macro
depythontex
deweb
dosepsbin
dtxgen
dvi2fax
dviasm
dvired
e2pall
epstopdf
findhyph
fmtutil
fmtutil-sys
fontinst
fragmaster
installfont-tl
kpsepath
kpsetool
kpsewhere
kpsexpand
latex-git-log
latex2man
latexdiff
latexdiff-vc
latexfileversion
latexindent
latexmk
latexpand
latexrevise
listings-ext.sh
ltxfileinfo
ltximg
lua2dox_filter
luaotfload-tool
luatools
make4ht
match_parens
mf2pt1
mkjobtexmf
mkt1font
mktexfmt
mptopdf
mtxrun
mtxrunjit
ot2kpx
pdf180
pdf270
pdf90
pdfatfi
pdfbook
pdfbook2
pdfcrop
pdfflip
pdfjam
pdfjam-pocketmod
pdfjam-slides3up
pdfjam-slides6up
pdfjoin
pdfnup
pdfpun
pdfxup
pfarrei
pkfix
pkfix-helper
ps2eps
ps2frag
pslatex
purifyeps
pythontex
repstopdf
rpdfcrop
rungs
simpdftex
srcredact
sty2dtx
tex4ebook
texconfig
texconfig-dialog
texconfig-sys
texcount
texdef
texdiff
texdirflatten
texdoc
texdoctk
texexec
texfot
texindy
texlinks
texliveonfly
texloganalyser
texmfstart
thumbpdf
typeoutfileinfo
updmap
updmap-sys
vpl2ovp
vpl2vpl
xindy
"
   _games_scripts="rubikrotation"
   _htmlxml_scripts="ht htcontext htlatex htmex httex httexi htxelatex htxetex mk4ht"
   _humanities_scripts="diadia"
   _langcyrillic_scripts="rubibtex rumakeindex"
   _langextra_scripts="ebong"
   _langgreek_scripts="mkgrkindex"
   _langjapanese_scripts="convbkmk ptex2pdf
kanji-fontmap-creator
kanji-config-updmap
kanji-config-updmap-sys
"
   _langkorean_scripts="jamo-normalize komkindex ttf2kotexfont"
   _latexextra_scripts="
authorindex
exceltex
makedtx
makeglossaries
makeglossaries-lite
pdfannotextractor
perltex
ps4pdf
splitindex
svn-multi
vpe
yplan"
   _music_scripts="lily-glyph-commands lily-image-commands lily-rebuild-pdfs m-tx musixtex musixflx pmx2pdf pmxchords"
   _pictures_scripts="cachepic epspdf epspdftk fig4latex getmapdl mathspic mkpic pn2pdf"
   _pstricks_scripts="pedigree pst2pdf"
   _science_scripts="pygmentex ulqda"
   for s in \
        ${_bibtexextra_scripts} \
        ${_core_scripts}       \
        ${_games_scripts}       \
        ${_htmlxml_scripts}    \
        ${_langcyrillic_scripts} \
        ${_langextra_scripts}  \
        ${_langgreek_scripts}  \
        ${_langjapanese_scripts} \
        ${_langkorean_scripts} \
        ${_latexextra_scripts} \
        ${_music_scripts}      \
        ${_pictures_scripts}   \
        ${_pstricks_scripts}   \
        ${_science_scripts}    \
        tlmgr; do
       ! readlink -e "$CACHE_PATH"/usr/bin/$s && rm "$CACHE_PATH"/usr/bin/$s
   done
   ###################################################################
}

