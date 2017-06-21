pkg_origin=cosmos

pkg_name=nfs-utils
pkg_version=2.1.1
pkg_description="Support programs for Network File Systems"
pkg_upstream_url='http://nfs.sourceforge.net'
pkg_license=('GPL')
backup=(etc/{exports,nfs.conf,nfsmount.conf})
pkg_deps=('glibc' 'e2fsprogs' 'rpcbind' 'libtirpc' 'librpcsecgss' 'nfsidmap' 'libevent'
         'device-mapper' 'sqlite')
pkg_build_deps=('pkgconfig' 'autoconf' 'automake')
#install=nfs-utils.install
pkg_source=("https://downloads.sourceforge.net/project/nfs/nfs-utils/${pkg_version}/${pkg_name}-${pkg_version}.tar.bz2"
        'exports'
        'id_resolver.conf')
pkg_shasum=('1157abcfaa8670f990f408cf280426b4'
         'e6ad3c7a59c7e4c24965a0e7da35026c'
         '391aaafdf01a665629c708d1386b5896')

do_build() {
  cd ${pkg_name}-${pkg_version}
  
  ./configure --prefix=/usr \
    --enable-nfsv4 \
    --enable-nfsv41 \
    --enable-gss \
    --without-tcp-wrappers \
    --with-statedir=/var/lib/nfs \
    --enable-ipv6 \
    --sysconfdir=/etc \
    --enable-libmount-mount \
    --without-gssglue \
    --enable-mountconfig 
  make 
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  make DESTDIR=${pkg_prefix} install

  install -D -m 644 utils/mount/nfsmount.conf ${pkg_prefix}/etc/nfsmount.conf
  install -D -m 644 nfs.conf ${pkg_prefix}/etc/nfs.conf

  # systemd files
  for i in systemd/{*.service,*.mount,*.target}; do
    install -D -m 644 $i ${pkg_prefix}/usr/lib/systemd/system/$(basename $i)
  done
  
  install -d -m 644 ${pkg_prefix}/usr/share/doc/${pkg_name}
  install -m 644 NEWS ${pkg_prefix}/usr/share/doc/${pkg_name}/
  install -m 644 README ${pkg_prefix}/usr/share/doc/${pkg_name}/
  
  cd ..
  install -D -m 644 exports          ${pkg_prefix}/etc/exports
  install -D -m 644 id_resolver.conf ${pkg_prefix}/etc/request-key.d/id_resolver.conf
  
  mkdir ${pkg_prefix}/etc/exports.d
  mkdir -m 555 ${pkg_prefix}/var/lib/nfs/rpc_pipefs
  mkdir ${pkg_prefix}/var/lib/nfs/v4recovery
}

