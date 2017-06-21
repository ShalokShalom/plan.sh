pkg_origin=cosmos

pkg_name=rpcbind
pkg_version=0.2.4
pkg_description="portmap replacement which supports RPC over various protocols"
pkg_deps=('bash' 'glibc' 'libtirpc')
pkg_upstream_url="http://rpcbind.sourceforge.net"
pkg_license=('custom')
install=rpcbind.install
pkg_source=("http://downloads.sourceforge.net/sourceforge/rpcbind/${pkg_name}-${pkg_version}.tar.bz2" 
        'rpcbind-sunrpc.patch'
        'rpcbind.conf'
        'rpcbind.patch')
pkg_shasum=('cf10cd41ed8228fc54c316191c1f07fe'
         '30956322214e2eaee8d479f25c607533'
         '66ffa1a249150edaa9fae9101ec416de'
         '56552a9cb44cbbc405c2a1693b6e6f12')

do_build() {
  cd ${pkg_name}-${pkg_version}
  patch -p1 -i ${CACHE_PATH}/rpcbind-sunrpc.patch
  # http://seclists.org/oss-sec/2017/q2/209
  # https://github.com/guidovranken/rpcbomb/
  patch -p1 -i ${CACHE_PATH}/rpcbind.patch
  
  ./configure --prefix=/usr \
        --with-rpcuser=rpc \
        --enable-warmstarts \
        --with-statedir=/var/lib/rpcbind
  make 
}
do_package() {
  cd ${pkg_name}-${pkg_version}
  make DESTDIR=${pkg_prefix} install
  
  install -D -m644 ${CACHE_PATH}/rpcbind.conf ${pkg_prefix}/etc/conf.d/rpcbind
  install -d -m 700 -o 32 -g 32 ${pkg_prefix}/var/lib/rpcbind
  
  install -D -m644 COPYING ${pkg_prefix}/usr/share/licenses/rpcbind/COPYING
}
