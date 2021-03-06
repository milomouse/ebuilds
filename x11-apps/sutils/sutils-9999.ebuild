# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $ sutils-9999

EAPI=5

inherit flag-o-matic git-2 toolchain-funcs

DESCRIPTION="Small command-line utilities"
HOMEPAGE="https://github.com/baskerville/sutils"
SRC_URI=""
EGIT_REPO_URI="git://github.com/baskerville/sutils.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

RESTRICT="strip"

RDEPEND=""
DEPEND="virtual/pkgconfig"

src_compile() {
	emake PREFIX=/usr
}

src_install() {
	dobin ${PN}
	dodoc LICENSE
}
