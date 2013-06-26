# $Header: $

EAPI=5

inherit flag-o-matic git-2 toolchain-funcs

DESCRIPTION="Outputs X window titles"
HOMEPAGE="https://github.com/baskerville/xtitle"
SRC_URI=""
EGIT_REPO_URI="git://github.com/baskerville/xtitle.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

RESTRICT="strip"

RDEPEND="x11-libs/libxcb
x11-libs/xcb-util-wm"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_compile() {
	emake PREFIX=/usr
}

src_install() {
	dobin ${PN}
	dodoc LICENSE
}
