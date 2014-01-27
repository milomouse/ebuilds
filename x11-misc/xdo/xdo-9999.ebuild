# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $ xdo-9999

EAPI=5

inherit flag-o-matic git-2 toolchain-funcs

DESCRIPTION="Small X utility to perform elementary actions on windows"
HOMEPAGE="https://github.com/baskerville/xdo"
SRC_URI=""
EGIT_REPO_URI="git://github.com/baskerville/xdo.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

RESTRICT="strip"

RDEPEND=">=x11-libs/libxcb-1.9
	x11-libs/xcb-util-wm"
DEPEND="virtual/pkgconfig"

src_compile() {
	emake PREFIX=/usr
}

src_install() {
	dobin ${PN}
	dodoc LICENSE

	doman doc/${PN}.1
}
