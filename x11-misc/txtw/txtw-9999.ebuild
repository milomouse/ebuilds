# $Header: $

EAPI=5

inherit flag-o-matic git-2 toolchain-funcs

DESCRIPTION="Return the pixel width of the given strings for the given font"
HOMEPAGE="https://github.com/baskerville/txtw"
SRC_URI=""
EGIT_REPO_URI="git://github.com/baskerville/txtw.git"

LICENSE="Unlicense"
SLOT="0"
KEYWORDS=""
IUSE=""

RESTRICT="strip"

RDEPEND="x11-libs/cairo"
DEPEND="virtual/pkgconfig"

src_compile() {
	emake PREFIX=/usr
}

src_install() {
	dobin ${PN}
	dodoc LICENSE

	doman ${PN}.1
}
