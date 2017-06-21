pkg_origin=cosmos

pkg_name=faac
pkg_version=1.28
pkg_description="FAAC is an AAC audio encoder"
pkg_upstream_url="http://www.audiocoding.com/"
pkg_license=('GPL' 'custom')
pkg_deps=('libmp4v2' 'glibc')
pkg_build_deps=('automake' 'autoconf' 'libtool')
pkg_source=("https://downloads.sourceforge.net/faac/${pkg_name}-${pkg_version}.tar.gz"
        'mp4v2-1.9.patch'
        'mp4v2-2.0.0.patch'
        'altivec.patch')
pkg_shasum=('80763728d392c7d789cde25614c878f6'
         '9d52a17e68fa15ca94e88e1457b94b74'
         '979ff4f13f36217cb15c92df9fd75f0c'
         'e1ee422ab524fb1f78d178700c3a0e7f')

do_build() {
  patch -p1 -i ${CACHE_PATH}/mp4v2-1.9.patch 
  patch -p0 -i ${CACHE_PATH}/mp4v2-2.0.0.patch 
  patch -p0 -i ${CACHE_PATH}/altivec.patch 
  
  find . -type f -print0 | xargs -0 sed -i 's/\r//g'
  ./bootstrap
  ./configure --prefix=/usr 
  make 
}

do_package() {
  make DESTDIR=${pkg_prefix} install

  install -Dm644 libfaac/kiss_fft/COPYING ${pkg_prefix}/usr/share/licenses/faac/LICENSE
}
