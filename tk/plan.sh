pkg_origin=cosmos

pkg_name=tk
pkg_version=8.6.6
_pkg_version=8.6
pkg_description="A windowing toolkit for use with tcl"
pkg_upstream_url="http://tcl.sourceforge.net/"
pkg_license=('custom')
pkg_deps=("tcl=${pkg_version}" 'libxss' 'libxft')
pkg_source=("http://downloads.sourceforge.net/sourceforge/tcl/${pkg_name}${pkg_version}-src.tar.gz")
pkg_shasum=('dd7dbb3a6523c42d05f6ab6e86096e99')

do_build() {
  cd ${pkg_name}${pkg_version}/unix

  ./configure --prefix=/usr \
              --mandir=/usr/share/man \
              --enable-threads \
              --enable-xft \
              --enable-64bit
  
  make
  
  # LFS recommendation http://www.linuxfromscratch.org/blfs/view/svn/general/tk.html
  sed -e "s@^\(TK_SRC_DIR='\).*@\1/usr/include'@" \
      -e "/TK_B/s@='\(-L\)\?.*unix@='\1/usr/lib@" \
      -i tkConfig.sh
}

do_package() {
  cd ${pkg_name}${pkg_version}/unix
    
  make INSTALL_ROOT=${pkg_prefix} install install-private-headers
  ln -sf wish${_pkg_version} ${pkg_prefix}/usr/bin/wish

  install -Dm644 license.terms ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}

