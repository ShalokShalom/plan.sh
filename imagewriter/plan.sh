pkg_origin=

pkg_name=imagewriter
pkg_version=1.10.11
_commit=1d253d9
pkg_description="SUSE Studio Imagewriter"
pkg_upstream_url="https://github.com/mbarringer/imagewriter"
pkg_license=('GPLv2')
pkg_deps=('qt5-base' 'kde-cli-tools')
#pkg_source=("http://download.opensuse.org/source/factory/repo/oss/suse/src/imagewriter-${_pkg_version}-${_opensuse_rel}.src.rpm"
pkg_source=("https://github.com/openSUSE/imagewriter/tarball/master/imagewriter-${pkg_version}.tar.gz"
        'imagewriter.desktop')
pkg_shasum=('b0a65745a7d6938a2cd3db7e694ed062'
         '81df0c7c5f744d6a24413a37f6e6ecb6')

do_build() { 
  cd openSUSE-${pkg_name}-${_commit}
  
  /usr/lib/qt5/bin/qmake PREFIX=/usr DEFINES=USEUDISKS2 imagewriter.pro
  make CFLAGS="${CFLAGS} -DKIOSKHACK -Wno-unused-parameter"
}

do_package() {
  cd openSUSE-${pkg_name}-${_commit}
  make INSTALL_ROOT="${pkg_prefix}" install
  
  rm $pkg_prefix/usr/share/applications/imagewriter.desktop
  install -m 644 -p ${CACHE_PATH}/imagewriter.desktop ${pkg_prefix}/usr/share/applications/
}
