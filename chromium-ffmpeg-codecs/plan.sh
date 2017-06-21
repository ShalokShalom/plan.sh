pkg_origin=
 
pkg_name=chromium-ffmpeg-codecs
pkg_version=58.0.3029.81
pkg_description="Extra ffmpeg codecs from the Chromium Browser for use in other browsers"
pkg_upstream_url="https://ffmpeg.org/"
pkg_license=('LGPL2.1')
pkg_deps=('gtk2' 'gtk3' 'libexif' 'pulseaudio' 'libxss')
pkg_build_deps=('ninja' 'nss' 'pciutils' 'python2' 'xdg-utils' 'mesa')
pkg_source=("https://commondatastorage.googleapis.com/chromium-browser-official/chromium-$pkg_version.tar.xz"
        'gn.patch'
        "https://gitweb.gentoo.org/repo/gentoo.git/plain/www-client/chromium/files/chromium-gn-bootstrap-r2.patch")
pkg_shasum=('fe28227f5f4aa05709b9cbd47a5cf426'
         '3354997dd0bfde3443499133a6e16a85'
         '776649f56b8f7bcad7f23d496bba8042')

do_build() {
  cd chromium-${pkg_version}
  #touch chrome/test/data/webui/i18n_process_css_test.html
  #sed -i "s|base/callback_internal.cc|base/callback_helpers.cc|g" tools/gn/bootstrap/bootstrap.py
  #patch -p1 -i ${CACHE_PATH}/gn.patch
  patch -p1 -i ${CACHE_PATH}/chromium-gn-bootstrap-r2.patch

  local _flags=("ffmpeg_branding=\"ChromeOS\""
                'proprietary_codecs=true'
                'enable_hevc_demuxing=true'
                'use_gconf=false'
                'use_gio=false'
                'use_gnome_keyring=false'
                'use_kerberos=false'
                'use_cups=false'
                'use_sysroot=false'
                'use_gold=false'
                'linux_use_bundled_binutils=false'
                'use_allocator="none"'
                'is_clang=false'
                'clang_use_chrome_plugins=false'
                'fatal_linker_warnings=false'
                'treat_warnings_as_errors=false'
                'is_component_build=true'
                'is_debug=false'
                'symbol_level=0')
  
  python2 tools/gn/bootstrap/bootstrap.py --gn-gen-args "${_flags[*]}"
  out/Release/gn gen out/Release -v --args="${_flags[*]}" --script-executable=/usr/bin/python2

  ninja -C out/Release media/ffmpeg
}

do_package() {
  cd chromium-${pkg_version}

  install -Dm644 out/Release/libffmpeg.so ${pkg_prefix}/usr/lib/chromium/libs/libffmpeg.so
}
