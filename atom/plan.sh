pkg_origin=

pkg_name=atom
pkg_version=1.18.0
pkg_description="Hackable text editor from the 21st Century"
pkg_upstream_url="https://github.com/atom/atom"
pkg_license=('MIT')
pkg_deps=('alsa-lib' 'gconf' 'gtk2' 'libnotify' 'libxtst' 'nss' 'python2' 'libxkbfile')
pkg_build_deps=('git')
pkg_source=("https://github.com/atom/atom/releases/download/v${pkg_version}/atom-amd64.tar.gz"
        'atom.desktop')
pkg_shasum=('87aaa11ffb3e88ebdf8ca9b413711c14'
         '64c714a8832e5be9e43e532f37ea30ce')

do_package() {
  cd ${pkg_name}-${pkg_version}-amd64
  
  install -dm755 ${pkg_prefix}/usr/bin
  install -dm755 ${pkg_prefix}/usr/share/atom
  
  mv resources/app/atom.sh ${pkg_prefix}/usr/bin/atom
  cp -r * ${pkg_prefix}/usr/share/atom/

  install -Dm644 ${CACHE_PATH}/atom.desktop ${pkg_prefix}/usr/share/applications/atom.desktop
  install -Dm644 atom.png ${pkg_prefix}/usr/share/pixmaps/atom.png
  install -Dm644 LICENSE ${pkg_prefix}/usr/share/licenses/$pkg_name/LICENSE
}
