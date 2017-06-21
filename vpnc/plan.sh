pkg_origin=cosmos

pkg_name=vpnc
pkg_version=0.5.3.3
#_pkg_version=0.5.3.svn550
pkg_description="VPN client for cisco3000 VPN Concentrators"
pkg_upstream_url="http://www.unix-ag.uni-kl.de/~massar/vpnc/"
pkg_license=('GPL')
pkg_deps=('libgcrypt' 'openssl' 'iproute2')
pkg_build_deps=('subversion')
# get revision by cd to vpnc > svn info | awk '/^Revision:/ { print $2 }'
pkg_source=("vpnc::svn+http://svn.unix-ag.uni-kl.de/vpnc/trunk#revision=550"
        'vpnc.conf')
backup=(etc/vpnc/default.conf)
pkg_shasum=('SKIP'
         'a3f4e0cc682f437e310a1c86ae198e45')

do_build() {
  cd $pkg_name

  # Build hybrid support
  sed -i 's|^#OPENSSL|OPENSSL|g' Makefile

  make 
}

do_package() {
  cd $pkg_name
  
  make DESTDIR=$pkg_prefix PREFIX=/usr install

  install -D -m644 $CACHE_PATH/vpnc.conf $pkg_prefix/etc/vpnc/default.conf
}


