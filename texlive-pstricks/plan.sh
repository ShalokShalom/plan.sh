pkg_origin=cosmos

pkg_name=texlive-pstricks
pkg_version=2012.26865
_pkg_version=${pkg_version#2012.}
pkg_description="TeX Live - Additional PSTricks packages."
pkg_license=('GPL3')
pkg_deps=('texlive-core')
groups=('texlive-most')
pkg_upstream_url='http://tug.org/texlive/'
install=texlive.install
pkg_source=("ftp://ftp.archlinux.org/other/texlive/$pkg_name-$pkg_version-src.zip")
pkg_shasum=('18c1f8e54233a31f292c4705148afcf7')

do_build() {
  for p in *.tar.xz; do
    bsdtar -xf $p
  done
  rm -rf {tlpkg,doc,source} || true
}

do_package() {
   install -m755 -d $CACHE_PATH/var/lib/texmf/arch/installedpkgs
   sed -i '/^#/d' CONTENTS
   install -m644 CONTENTS $CACHE_PATH/var/lib/texmf/arch/installedpkgs/${pkg_name}_$_pkg_version.pkgs
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
   ln -s /usr/share/texmf-dist/scripts/pst2pdf/pst2pdf $CACHE_PATH/usr/bin/pst2pdf
   ln -s /usr/share/texmf-dist/scripts/pedigree-perl/pedigree.pl $CACHE_PATH/usr/bin/pedigree
}
