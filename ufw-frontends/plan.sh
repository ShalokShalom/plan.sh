pkg_origin=

pkg_name=ufw-frontends
pkg_version=0.3.2
_commit=74dc4ec85985ce77a470fbc26b2baa90789542f9
pkg_description="Project that implements a graphical frontends for UFW using PyGTK."
pkg_upstream_url="https://github.com/baudm/ufw-frontends"
pkg_license=('GPL3')
pkg_deps=('ufw' 'pygtk' 'sudo' 'kdesu' 'python2-pyinotify')
pkg_source=("https://github.com/baudm/ufw-frontends/archive/${_commit}.zip")
pkg_shasum=('c74b0d86da10355629439405135291ec')

do_package() {
  cd ${CACHE_PATH}/ufw-frontends-${_commit}
  python2 setup.py build install --root=${pkg_prefix} 

  sed -i 's/su-to-root -X -c/kdesu/g' ${pkg_prefix}/usr/share/applications/ufw-gtk.desktop
}
