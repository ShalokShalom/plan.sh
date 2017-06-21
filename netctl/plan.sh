pkg_origin=cosmos

pkg_name=netctl
pkg_version=1.13
pkg_description="Profile based systemd network management"
pkg_upstream_url="http://projects.archlinux.org/netctl.git/"
pkg_license=("GPL")
pkg_deps=('coreutils' 'iproute2' 'openresolv')
pkg_build_deps=('pkg-config') 
optpkg_deps=('dialog: for the menu based wifi assistant'
            'dhclient: for DHCP support (or dhcpcd)'
            'dhcpcd: for DHCP support (or dhclient)'
            'wpa_supplicant: for wireless networking support'
            'wpa_actiond: for automatic wireless connections through netctl-auto'
            'ppp: for pppoe connections')
pkg_source=("https://sources.archlinux.org/other/packages/netctl/netctl-${pkg_version}.tar.xz")
pkg_shasum=('a8ae5a62d10d7660bb2dd43faee8b794')

do_package() {
  cd netctl-${pkg_version}
  make DESTDIR=${pkg_prefix} install

  # Shell Completion
  install -D -m644 contrib/bash-completion ${pkg_prefix}/usr/share/bash-completion/completions/netctl
  install -D -m644 contrib/zsh-completion ${pkg_prefix}/usr/share/zsh/site-functions/_netctl
}
