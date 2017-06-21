pkg_origin=

pkg_name=genymotion
pkg_version=2.6.0
pkg_description="Complete set of tools that provides a virtual environment for Android."
pkg_license="UNKNOWN"
pkg_upstream_url="http://www.genymotion.com/"
pkg_deps=('virtualbox' 'qt5-webkit' 'qt5-script' 'libpng' 'net-tools' 'qca-qt5' 'ffmpeg' 'protobuf')
install=genymotion.install
pkg_source=("$pkg_name.bin::http://files2.genymotion.com/genymotion/genymotion-$pkg_version/genymotion-${pkg_version}-linux_x64.bin"
        'genymotion.desktop')
pkg_shasum=('dfaacc18830ec395251651b06da667f9'
         '5b45045116a825fe75ac38f3f23f2e1f')

do_package(){
   cd $CACHE_PATH

   install -d $pkg_prefix/opt
   chmod +x $pkg_name.bin
   yes | ./$pkg_name.bin -d $pkg_prefix/opt
   #rm $pkg_prefix/opt/genymotion/libQt*
   #rm $pkg_prefix/opt/genymotion/sqldrivers/libqsqlite.so

   install -d $pkg_prefix/usr/bin
   ln -s /opt/genymotion/genymotion $pkg_prefix/usr/bin/genymotion
   ln -s /opt/genymotion/genymotion-shell $pkg_prefix/usr/bin/genymotion-shell
   ln -s /opt/genymotion/player $pkg_prefix/usr/bin/genymotion-player
   install -Dm644 $CACHE_PATH/genymotion.desktop $pkg_prefix/usr/share/applications/genymotion.desktop
   chown -R root:root $pkg_prefix/opt/genymotion
}
