pkg_origin=

pkg_name=wire-desktop
pkg_version=2.13.2741
pkg_description="Cross platform desktop app, wrapping the wire-webapp. Based on Electron"
pkg_upstream_url="https://wire.com/en/"
pkg_license=('GPL3')
pkg_deps=('alsa-lib' 'gconf' 'gtk2' 'libxtst' 'nodejs' 'nss' 'python2')
pkg_source=("https://github.com/wireapp/wire-desktop/archive/release/${pkg_version}.tar.gz"
        'wire-desktop.desktop')
pkg_shasum=('12d3022464cafeaae57ce151d863c388'
         '32a998ab2d5cec93ab975e5aff4ad223')

do_build() {
  cd ${pkg_name}-release-${pkg_version}
  
  npm install
  node_modules/.bin/build --linux --x64 --dir
}

do_package() {
  cd ${pkg_name}-release-${pkg_version}
  
  install -d ${pkg_prefix}/usr/lib/${pkg_name}
  install -d ${pkg_prefix}/usr/bin
  
  cp -a wrap/dist/linux-unpacked/* ${pkg_prefix}/usr/lib/${pkg_name}
  ln -s /usr/lib/${pkg_name}/${pkg_name} ${pkg_prefix}/usr/bin/${pkg_name}

  install -Dm644 ../${pkg_name}.desktop ${pkg_prefix}/usr/share/applications/${pkg_name}.desktop
  install -Dm644 resources/icons/256x256.png ${pkg_prefix}/usr/share/pixmaps/${pkg_name}.png
  install -Dm644 LICENSE ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
