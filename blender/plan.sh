pkg_origin=

pkg_name=blender
# adjust .desktop for version
pkg_version=2.78.3
_pkg_version=2.78c
pkg_description="A fully integrated 3D graphics creation suite"
pkg_license=('GPL')
pkg_upstream_url="http://www.blender.org"
pkg_deps=('desktop-file-utils' 'shared-mime-info' 'hicolor-icon-theme' 'xdg-utils')
pkg_source=("http://download.blender.org/release/Blender2.78/${pkg_name}-${_pkg_version}-linux-glibc219-x86_64.tar.bz2"
        'blender.desktop')
pkg_shasum=('6aec4319f0a0cd632f48e07e2866d2ab'
         '1eff2e64e226e485923db960a6ab0212')

do_package() {
  cd ${pkg_name}-${_pkg_version}-linux-glibc219-x86_64
  
  install -d ${pkg_prefix}/opt
  mv -iv ${CACHE_PATH}/${pkg_name}-${_pkg_version}-linux-glibc219-x86_64 ${pkg_prefix}/opt
  
  mkdir -p ${pkg_prefix}/usr/share/icons/hicolor/scalable/apps
  install -m 644 -p ${pkg_prefix}/opt/${pkg_name}-${_pkg_version}-linux-glibc219-x86_64/icons/scalable/apps/blender.svg \
      ${pkg_prefix}/usr/share/icons/hicolor/scalable/apps/blender.svg

  install -Dm644 ${CACHE_PATH}/${pkg_name}.desktop ${pkg_prefix}/usr/share/applications/${pkg_name}.desktop
}
