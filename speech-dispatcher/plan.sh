pkg_origin=cosmos

pkg_name=speech-dispatcher
pkg_version=0.8.7
pkg_upstream_url="https://devel.freebsoft.org/speechd"
pkg_description="High-level device independent layer for speech synthesis interface"
pkg_license=('GPL2' 'FDL')
pkg_deps=('glib2' 'libtool' 'dotconf' 'pyxdg' 'pulseaudio' )
pkg_build_deps=('intltool' 'espeak')
optpkg_deps=('espeak: Text-To-Speak (TTS) engine')
backup=(etc/speech-dispatcher/clients/emacs.conf
        etc/speech-dispatcher/modules/ibmtts.conf
        etc/speech-dispatcher/modules/espeak-generic.conf
        etc/speech-dispatcher/modules/espeak.conf
        etc/speech-dispatcher/modules/swift-generic.conf
        etc/speech-dispatcher/modules/festival.conf
        etc/speech-dispatcher/modules/cicero.conf
        etc/speech-dispatcher/modules/espeak-mbrola-generic.conf
        etc/speech-dispatcher/modules/dtk-generic.conf
        etc/speech-dispatcher/modules/llia_phon-generic.conf
        etc/speech-dispatcher/modules/ivona.conf
        etc/speech-dispatcher/modules/epos-generic.conf
        etc/speech-dispatcher/modules/flite.conf
        etc/speech-dispatcher/speechd.conf)
install=speech-dispatcher.install
pkg_source=("http://www.freebsoft.org/pub/projects/speechd/$pkg_name-$pkg_version.tar.gz"
        'speech-dispatcherd.service')
pkg_shasum=('6ffe4aff58154a06c14da66cd045fa8c'
         '0f09abe1af4eb79885ba88a1c2bcde8b')


do_build() {
  
  ./configure --prefix=/usr --sysconfdir=/etc --without-flite
  make
}

do_package() {
  make DESTDIR=${CACHE_PATH} install

  install -Dm644 ${CACHE_PATH}/speech-dispatcherd.service ${CACHE_PATH}/usr/lib/systemd/system/speech-dispatcherd.service
  install -d ${CACHE_PATH}/var/log/speech-dispatcher
  
  #sed -i -e 's|# DisableAutoSpawn|DisableAutoSpawn|' ${CACHE_PATH}/etc/speech-dispatcher/speechd.conf
}
