pkg_origin=cosmos

pkg_name=cpupower
pkg_version=4.9
pkg_description='Linux kernel tool to examine and tune power saving related features of your processor'
pkg_license=('GPL2')
pkg_upstream_url='http://www.kernel.org'
pkg_deps=('pciutils')
pkg_build_deps=('asciidoc' 'xmlto')
backup=('etc/default/cpupower')
pkg_source=("http://ftp.kernel.org/pub/linux/kernel/v4.x/linux-${pkg_version}.tar.xz"
        #"http://ftp.kernel.org/pub/linux/kernel/v4.x/patch-${pkg_version}.1.xz"
        'cpupower.conf'
        'cpupower.service'
        'cpupower.systemd')
pkg_shasum=('0a68ef3615c64bd5ee54a3320e46667d'
         #'349734be5387f1605074515ad7207627'
         'fb4b3d184850f5972c5a1bba3ead4e05'
         '2450e8ff41b30eb58d43b5fffbfde1f4'
         'e02e88977fbdde29a2ae38aa064a367d')

do_build() {
  if (( NOEXTRACT == 0 )) && [[ -e "$CACHE_PATH"/patch-* ]]; then
    msg2 'Applying stable patch set'
    patch -N -p1 -i "$CACHE_PATH"/patch-*
  fi

  pushd linux-$pkg_version/tools/power/cpupower
  
  LDFLAGS=${LDFLAGS:+"$LDFLAGS,--no-as-needed"}
  make VERSION=$pkg_version-$pkgrel
  popd
}

do_package() {
  pushd linux-$pkg_version/tools/power/cpupower
  make \
    DESTDIR="$pkg_prefix" \
    mandir='/usr/share/man' \
    docdir='/usr/share/doc/cpupower' \
    install install-man
  popd

  install -Dm 644 cpupower.conf "$pkg_prefix/etc/default/cpupower"
  install -Dm 644 cpupower.service "$pkg_prefix/usr/lib/systemd/system/cpupower.service"
  install -Dm 755 cpupower.systemd "$pkg_prefix/usr/lib/systemd/scripts/cpupower"
}

