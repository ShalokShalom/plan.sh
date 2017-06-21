pkg_origin=

pkg_name=eric6
pkg_version=17.06
pkg_description="Full-featured Python 3.x and Ruby IDE written in python, based on the cross 
        platform Qt gui toolkit, integrating the highly flexible Scintilla editor control"
pkg_upstream_url="http://eric-ide.python-projects.org/"
pkg_license=('GPL3')
pkg_deps=('python3' 'pyqt5-python3' 'python3-qscintilla-qt5' 'python3-pylint')
pkg_source=("https://downloads.sourceforge.net/eric-ide/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('ba2a35f7b097a252a3d890166e43de90')

do_package() {
    cd ${pkg_name}-${pkg_version}

    python3 install.py -c -b /usr/bin -i ${pkg_prefix}
}
