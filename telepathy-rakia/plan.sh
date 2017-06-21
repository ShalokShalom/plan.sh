pkg_origin=cosmos

pkg_name=telepathy-rakia
pkg_version=0.7.4
pkg_description="A SIP-protocol connection manager for the Telepathy framework based on SofiaSIP-stack."
pkg_upstream_url="http://telepathy.freedesktop.org"
pkg_license=('LGPL')
pkg_deps=('telepathy-glib' 'sofia-sip')
pkg_build_deps=('libxslt' 'python2')
install=telepathy-rakia.install
groups=('telepathy')
pkg_source=("http://telepathy.freedesktop.org/releases/$pkg_name/$pkg_name-$pkg_version.tar.gz"
        'conf.patch')
pkg_shasum=('f9f47f18db033afe29fd6963c7748e37'
         '03c69793fecad0a2a2a5bbd9c92e82ab')

do_build() {
  patch -p0 -i $CACHE_PATH/conf.patch
  
  autoreconf -fi
  ./configure --prefix=/usr --libexecdir=/usr/lib/telepathy
  make
}

do_package() {
  
  make DESTDIR="${CACHE_PATH}" install
}
