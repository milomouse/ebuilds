# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $ ngetty-1.1

EAPI=3

DESCRIPTION="Daemon that starts login sessions on virtual console terminals, on demand"
HOMEPAGE="http://riemann.fmi.uni-sofia.bg/ngetty/"
SRC_URI="${HOMEPAGE}/${PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="dietlibc"

RESTRICT="strip"

DEPEND="
	!dietlibc? ( sys-libs/glibc )
	dietlibc? ( dev-libs/dietlibc )"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i "s/^CFLAGS = .*/CFLAGS = $CFLAGS/" Makefile
}

src_compile() {
	if use dietlibc ; then
		emake CC='diet -Os gcc -W' all
	else
		emake all
	fi
}

src_install() {
	sed -i 's/-g utmp/-g root/' Makefile
	emake DESTDIR="${D}" install install_other
	dodoc COPYING sample.Conf
}
