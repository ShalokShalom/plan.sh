pkg_origin=cosmos

pkg_name=rtmpdump
pkg_version=2.4.2
_commit=dc76f0a8461e6c8f1277eba58eae201b2dc1d06a
pkg_description="A tool to download rtmp streams"
pkg_upstream_url="http://rtmpdump.mplayerhq.hu/"
pkg_license=('GPL2' 'LGPL2.1')
pkg_deps=('openssl')
groups=('network')
#pkg_source=("http://rtmpdump.mplayerhq.hu/download/${pkg_name}-${pkg_version}.tar.gz")
# from http://repo.or.cz/w/rtmpdump.git/snapshot/dc76f0a8461e6c8f1277eba58eae201b2dc1d06a.tar.gz
pkg_source=("https://sourceforge.net/projects/kaosx/files/sources/${pkg_name}/${pkg_name}-${_commit}.tar.gz")
pkg_shasum=('ca05d7b93d9910cf2da4d96e7c2859bb')

do_build() {
  
  make
}

do_package() {
  install -d -m755 ${CACHE_PATH}/usr/lib
  
  make prefix=/usr mandir=/usr/share/man DESTDIR=${CACHE_PATH} install
}
