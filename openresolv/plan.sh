pkg_origin=cosmos

pkg_name=openresolv
pkg_version=3.9.0
pkg_description="resolv.conf management framework (resolvconf)"
pkg_upstream_url="http://roy.marples.name/projects/openresolv"
pkg_license=('custom:BSD')
pkg_deps=('bash')
pkg_build_deps=('systemd')
backup=('etc/resolvconf.conf')
pkg_source=("http://roy.marples.name/downloads/openresolv/${pkg_name}-${pkg_version}.tar.xz"
        'fs33801.patch')
pkg_shasum=('177ad48b768d4d1bf37510f1af99dffe'
         '1e58ffbd83c55a7c51afb8a5d8b74742')

do_build() {
  cd ${pkg_name}-${pkg_version}
  #patch -p1 -i ${CACHE_PATH}/fs33801.patch

  ./configure --prefix=/usr --sysconfdir=/etc --libexecdir=/usr/lib/resolvconf
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  make DESTDIR=${pkg_prefix} install

  mkdir -p ${pkg_prefix}/usr/share/licenses/${pkg_name}
  sed -n '2,25{s:^# \?::;p}' resolvconf.in > ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}

