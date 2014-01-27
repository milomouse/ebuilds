# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $ tint2-9999

EAPI="5"

inherit toolchain-funcs eutils subversion cmake-utils

DESCRIPTION="A lightweight panel/taskbar"
HOMEPAGE="http://code.google.com/p/tint2/"
ESVN_REPO_URI="http://tint2.googlecode.com/svn/trunk/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples tint2conf startup-notification"

COMMON_DEPEND="dev-libs/glib:2
	x11-libs/cairo
	x11-libs/pango[X]
	x11-libs/libX11
	x11-libs/libXinerama
	x11-libs/libXdamage
	x11-libs/libXcomposite
	x11-libs/libXrender
	x11-libs/libXrandr
	>=media-libs/imlib2-1.4.2[X]"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig
	x11-proto/xineramaproto"
RDEPEND="${COMMON_DEPEND}
	tint2conf? ( x11-misc/tintwizard )
	startup-notification? ( x11-libs/startup-notification )"

S=${WORKDIR}/${PN}

src_unpack() {
	subversion_src_unpack
}

src_configure() {
	BUILD_DIR="${WORKDIR}/${PN}/build"

	local mycmakeargs=(
		$(cmake-utils_use_enable examples EXAMPLES)
		$(cmake-utils_use_enable tint2conf TINT2CONF)
		"-DCMAKE_INSTALL_PREFIX=/usr"
		"-DDOCDIR=/usr/share/doc/${PF}"
	)

	cmake-utils_src_configure
}

src_install() {
	cd build

	cmake-utils_src_install
	rm -f "${D}/usr/bin/tintwizard.py"

	cd ../
	dodoc AUTHORS README ChangeLog
	doman doc/${PN}.1

	if use examples ; then
		dodir /usr/share/doc/"${PF}"/examples/
		cp -R "${S}"/tint2/sample/*.tint2rc "${D}"/usr/share/doc/"${PF}"/examples/
	fi

	docompress -x /usr/share/doc/${PF}/
}
