pkg_origin=

pkg_name=screenfetch
_pkg_name=screenFetch
pkg_version=3.8.0
epoch=1
pkg_description="Bash screenshot info grabber (DE, WM, theme, uptime, etc)"
pkg_upstream_url="https://github.com/KittyKatt/screenFetch"
pkg_license=('GPL')
pkg_deps=('bash' 'xorg-utils')
pkg_source=("https://github.com/KittyKatt/${_pkg_name}/archive/v${pkg_version}.tar.gz")
pkg_shasum=('65254e010e26813b4dc920ebb8a56593')

do_prepare() {
  cd ${_pkg_name}-${pkg_version}
  
  #patch -p1 -i ${CACHE_PATH}/ac7300aa6e8e5b4afd6203a4d916b9af1929ca8d.patch
}

do_package() {
  cd ${_pkg_name}-${pkg_version}
    
  install -Dm755 screenfetch-dev $pkg_prefix/usr/bin/screenfetch
  install -Dm644 screenfetch.1 $pkg_prefix/usr/share/man/man1/screenfetch.1
}

