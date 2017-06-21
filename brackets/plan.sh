pkg_origin=

pkg_name=brackets
pkg_version=1.9
pkg_description="Open source code editor for web designers and front-end developers."
pkg_upstream_url="http://brackets.io"
pkg_license=("MIT")
pkg_deps=('gconf' 'nss' 'systemd' 'desktop-file-utils' 'hicolor-icon-theme' 'gtk2')
pkg_build_deps=('prelink')
optpkg_deps=("google-chrome: to enable Live Preview"
            "gnuplot: to enable node benchmarking"
            "ruby: to enable LiveDevelopment Inspector")
install=${pkg_name}.install
pkg_source=("https://github.com/adobe/brackets/releases/download/release-${pkg_version}/Brackets.Release.${pkg_version}.64-bit.deb"
        'libgcrypt.so.11.8.2')
pkg_shasum=('ad904786545fce0c854c5e00d960a031'
         'a17acc9851185dd5f219458140e6ccda')

do_prepare() {
  cd $CACHE_PATH/

  tar -xf data.tar.xz
  execstack -c opt/${pkg_name}/Brackets
}

do_package() {
  install -d ${pkg_prefix}/opt
  cp -r opt/${pkg_name} ${pkg_prefix}/opt/${pkg_name}

  chmod -R a+rw ${pkg_prefix}/opt/${pkg_name}/samples

  install -d ${pkg_prefix}/usr/bin
  ln -s /opt/brackets/brackets ${pkg_prefix}/usr/bin/${pkg_name}

  local _icon_dir="usr/share/icons/hicolor"
  install -d ${pkg_prefix}/$_icon_dir/scalable/apps
  install -Dm644 $_icon_dir/scalable/apps/${pkg_name}.svg ${pkg_prefix}/$_icon_dir/scalable/apps/${pkg_name}.svg
  for _icon in "opt/brackets/appshell"*.png; do
    local _icon_size=${_icon##*/appshell}
    install -d ${pkg_prefix}/$_icon_dir/${_icon_size%.png}x${_icon_size%.png}/apps
    install -Dm644 $_icon ${pkg_prefix}/$_icon_dir/${_icon_size%.png}x${_icon_size%.png}/apps/${pkg_name}.png
  done

  install -d ${pkg_prefix}/usr/share/applications
  sed 's/Development/Development;/' opt/${pkg_name}/${pkg_name}.desktop > ${pkg_prefix}/usr/share/applications/${pkg_name}.desktop

  install -Dm755 usr/share/doc/${pkg_name}/copyright ${pkg_prefix}/usr/share/licenses/${pkg_name}/copyright
  #libgcrypt 1.6.0 fix 
  install -m755 ${CACHE_PATH}/libgcrypt.so.11.8.2 ${pkg_prefix}/opt/brackets/libgcrypt.so.11
}
