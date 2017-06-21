pkg_origin=cosmos

pkg_name=python2-matplotlib
pkg_version=2.0.2
pkg_description="Python plotting library, making publication quality plots"
pkg_upstream_url='http://matplotlib.org'
pkg_license=('custom')
pkg_deps=('python2-pytz' 'python2-numpy' 'python2-cairo' 'pyqt5-python2' 'python2-dateutil'
         'python2-pyparsing' 'python2-cycler')
pkg_build_deps=('tk' 'python2-gobject3' 'python2-pyparsing' 'python2-six'
             'ghostscript' 'texlive-bin')
optpkg_deps=('tk: used by the TkAgg backend'
            'ghostscript: usetex dependencies'
            'texlive-bin: usetex dependencies')
#pkg_source=("https://pypi.python.org/packages/source/m/matplotlib/matplotlib-${pkg_version}.tar.gz")
pkg_source=("https://github.com/matplotlib/matplotlib/archive/v${pkg_version}.tar.gz")
pkg_shasum=('89717c1ef3c6fdcd6fb1f3b597a4858c')

do_build() {
   
   python2 setup.py build
}

do_package() {
   python2 setup.py install -O1 --skip-build --root ${CACHE_PATH} --prefix=/usr

   install -dm755 ${CACHE_PATH}/usr/share/licenses/python2-matplotlib
   install -m 644 doc/users/license.rst ${CACHE_PATH}/usr/share/licenses/python2-matplotlib
}

