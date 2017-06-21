pkg_origin=cosmos

pkg_name=texlive-fontsextra
pkg_version=2012.26866
_revnr=${pkg_version#2012.}
pkg_description="TeX Live - all sorts of extra fonts"
pkg_license=('GPL')
pkg_deps=('texlive-core')
groups=('texlive-most')
pkg_upstream_url='http://tug.org/texlive/'
pkg_source=("ftp://ftp.archlinux.org/other/texlive/$pkg_name-$pkg_version-src.zip" "$pkg_name.maps")
install=texlive.install
pkg_shasum=('f75e552c4573ce73d3eee03fffee723f'
         '4a2f2b3b4527655fb47ab0d59b01bfea')

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
   
   # remove stuff depending on omega/aleph
   rm -rf $CACHE_PATH/usr/share/texmf-dist/omega
   find $CACHE_PATH/ -wholename '*ocherokee*' -delete
   find $CACHE_PATH/ -wholename '*oinuit*' -delete
}
