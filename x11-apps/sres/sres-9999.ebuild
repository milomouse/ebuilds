# $Header: $

EAPI=5

inherit flag-o-matic git-2 toolchain-funcs

DESCRIPTION="Print the current screen resolution"
HOMEPAGE="https://github.com/baskerville/sres"
SRC_URI=""
EGIT_REPO_URI="git://github.com/baskerville/sres.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

RESTRICT="strip"

RDEPEND=">=x11-libs/libxcb-1.9"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_compile() {
	emake PREFIX=/usr
}

src_install() {
	dobin ${PN}
	dodoc LICENSE
}
