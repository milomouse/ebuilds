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

RDEPEND=">=x11-libs/libxcb-1.9"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_compile() {
	emake PREFIX=/usr
}

src_install() {
	emake PREFIX=/usr DESTDIR="${D}" install
	install -D -m644 LICENSE "${D}/usr/share/licenses/sres/LICENSE"
}
