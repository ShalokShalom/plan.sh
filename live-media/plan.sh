pkg_origin=cosmos

pkg_name=live-media
pkg_version=2017.06.04
pkg_description="A set of C++ libraries for multimedia streaming"
pkg_license=('LGPL')
pkg_upstream_url="http://live555.com/liveMedia"
pkg_deps=('gcc-libs')
pkg_source=("http://live555.com/liveMedia/public/live.${pkg_version}.tar.gz")
pkg_shasum=('a36bb3cb9d7b6908ecb6efd48090be4f')

do_build() {

  sed \
      -e 's/$(INCLUDES) -I. -O2 -DSOCKLEN_T/$(INCLUDES) -I. -O2 -I. -fPIC -DRTSPCLIENT_SYNCHRONOUS_INTERFACE=1 -DSOCKLEN_T/g' \
      -i config.linux
  ./genMakefiles linux
  make
}

do_package() {

  for dir in BasicUsageEnvironment groupsock liveMedia UsageEnvironment; do
    install -dm755 ${pkg_prefix}/usr/{bin,lib,include/${dir}}
    install -m644 ${dir}/*.a "${pkg_prefix}/usr/lib"
    install -m644 ${dir}/include/*.h* "${pkg_prefix}/usr/include/${dir}"
  done

  for testprog in `find testProgs -type f -perm 755`; do
    install ${testprog} "${pkg_prefix}/usr/bin"
  done
}
