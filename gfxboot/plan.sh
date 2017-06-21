pkg_origin=cosmos

pkg_name=gfxboot
pkg_version=4.5.6
_pkg_version=1.1
pkg_license=('GPL')
pkg_description="Graphical Boot Logo tool"
pkg_upstream_url="http://www.opensuse.org"
pkg_deps=('perl-html-parser' 'freetype2' 'cpio' 'nasm')
pkg_build_deps=('rpmextract')
install=gfxboot.install
pkg_source=("http://download.opensuse.org/source/distribution/13.2/repo/oss/suse/src/${pkg_name}-${pkg_version}-${_pkg_version}.src.rpm"
        'gfxboot.html'
        'isolinux.patch')
pkg_shasum=('30435f328f89b4afee69d2f9f4b48db3'
         'f824c5bc2f716f8029677cae6956c1c7'
         '224289270f7ea288aaded3272a9c53f4')

do_build() {
    
  rpmextract.sh ${pkg_name}-${pkg_version}-${_pkg_version}.src.rpm 
  
  for i in $(find -name '*.tar.xz');do tar -Jxf $i;done
  mv -f themes ${pkg_name}-${pkg_version}/

  #chown -R root:root ${pkg_name}-${pkg_version}

  patch -p1 -i ${CACHE_PATH}/isolinux.patch
  make -s 
}

do_package() {
  make -s DESTDIR=$pkg_prefix installsrc 

  install -d -m 755 ${pkg_prefix}/usr/{sbin,share/man/man8,share/doc/gfxboot} 
  install -m 755 gfxboot gfxboot-compile gfxboot-font ${pkg_prefix}/usr/sbin 
  install -m 644 doc/gfxboot.8 ${pkg_prefix}/usr/share/man/man8/ 
  install -m 644 ../gfxboot.html ${pkg_prefix}/usr/share/doc/gfxboot 
}

# alternative source download
# pkg_source=(http://archpkg.rodp.net/src/${pkg_name}-${pkg_version}-${pkgrel}.src.rpm)
