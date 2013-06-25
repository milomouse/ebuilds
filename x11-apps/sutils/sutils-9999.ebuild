# $Header: $

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

RDEPEND=""
DEPEND="virtual/pkgconfig"

src_compile() {
	emake PREFIX=/usr
}

src_install() {
	emake PREFIX=/usr DESTDIR="${D}" install
	install -D -m644 LICENSE "${D}/usr/share/licenses/sutils/LICENSE"
}
