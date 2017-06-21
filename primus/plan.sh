pkg_origin=cosmos

pkg_name=primus
pkg_version=20150328
_commit=d1afbf6fce2778c0751eddf19db9882e04f18bfd
pkg_description="Faster OpenGL offloading for Bumblebee (git sources)"
pkg_upstream_url="https://github.com/amonakov/primus"
pkg_license=('custom:ISC')
pkg_deps=('bumblebee')
pkg_build_deps=('git')
pkg_source=("https://github.com/amonakov/primus/archive/${_commit}.zip")
pkg_shasum=('b9f72c731f38a95b10d61f3951275940')

do_build() {
  
  make
}

do_package() {

  install -D lib/libGL.so.1 $pkg_prefix/usr/lib/primus/libGL.so.1
  sed -e "s|^PRIMUS_libGL=.*|PRIMUS_libGL='/usr/\$LIB/primus'|" primusrun > primusrun.dist
  install -D primusrun.dist $pkg_prefix/usr/bin/primusrun
  
  install -D primus.bash-completion $pkg_prefix/etc/bash_completion.d/primusrun
  
  gzip -9 primusrun.1
  install -D primusrun.1.gz $pkg_prefix/usr/share/man/man1/primusrun.1.gz

  install -D -m644 LICENSE.txt $pkg_prefix/usr/share/licenses/$pkg_name/LICENSE
}
