pkg_origin=

pkg_name=kcp
pkg_version=0.87.5
_commit=2b4b112
pkg_description="A command-line tool for KaOS Community Packages"
pkg_upstream_url="https://github.com/bvaudour/kcp"
pkg_license=('Public Domain')
install=kcp.install
pkg_deps=('git')
pkg_build_deps=('go')
pkg_source=("https://github.com/bvaudour/kcp/tarball/master/kcp-${pkg_version}.tar.gz")
#pkg_source=("https://github.com/bvaudour/kcp/releases/download/${pkg_version}/kcp-${pkg_version}.tar.gz")
pkg_shasum=('5338fba9e12e0e41f8cbb27f316caba6')
 
do_build() {
  cd bvaudour-${pkg_name}-${_commit}
  
  export GOPATH=${GOPATH}:"${CACHE_PATH}"
  ./configure 
  make 
}

do_package() {
  cd bvaudour-${pkg_name}-${_commit} 
  make DESTDIR="${pkg_prefix}" install
  
  for files in i18n/kcp/*; do
  if [ -f "$files" ] && [ "$files" != 'i18n/kcp/kcp.pot' ]; then
        STRING_PO=`echo ${files#*/*/}`
        STRING=`echo ${STRING_PO%.po}`
        mkdir -p ${pkg_prefix}/usr/share/locale/${STRING}/LC_MESSAGES
        msgfmt $files -o ${pkg_prefix}/usr/share/locale/${STRING}/LC_MESSAGES/kcp.mo
        echo "${STRING} installed..."
  fi
  done
  
  for files in i18n/pckcp/*; do
  if [ -f "$files" ] && [ "$files" != 'i18n/pckcp/pckcp.pot' ]; then
        STRING_PO=`echo ${files#*/*/}`
        STRING=`echo ${STRING_PO%.po}`
        mkdir -p ${pkg_prefix}/usr/share/locale/${STRING}/LC_MESSAGES
        msgfmt $files -o ${pkg_prefix}/usr/share/locale/${STRING}/LC_MESSAGES/pckcp.mo
        echo "${STRING} installed..."
  fi
  done

  install -Dm644 LICENSE "${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE"
}
