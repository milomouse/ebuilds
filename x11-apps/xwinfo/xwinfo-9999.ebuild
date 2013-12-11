# $Header: $

EAPI=5

inherit flag-o-matic git-2 toolchain-funcs

DESCRIPTION="Window information utility for X"
HOMEPAGE="https://github.com/baskerville/xwinfo"
SRC_URI=""
EGIT_REPO_URI="git://github.com/baskerville/xwinfo.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

RESTRICT="strip"

RDEPEND=">=x11-libs/libxcb-1.6"
DEPEND="${RDEPEND}
	x11-libs/libX11
	>=x11-proto/xproto-7.0.17"

src_compile() {
	emake PREFIX=/usr
}

src_install() {
	dobin ${PN}
	dodoc LICENSE
}
