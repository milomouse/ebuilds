# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
ETYPE="sources"
KEYWORDS="~amd64"

inherit versionator

CKV="$(get_version_component_range 1-3)"
K_SECURITY_UNSUPPORTED="yes"
K_DEBLOB_AVAILABLE="1"

inherit kernel-2
detect_version

HOMEPAGE="http://www.kernel.org/pub/linux/kernel/projects/rt/"

## LINUX:
K_NAME="${PN%-sources}"
K_BRANCH_ID="${KV_MAJOR}.${KV_MINOR}"
## PREEMPT_RT:
RT_VERS="${PV/*_p}"
RT_NAME="patch-${K_BRANCH_ID}.${KV_PATCH}-rt${RT_VERS}.patch"
RT_FILE="${RT_NAME}.xz"
RT_LINK="https://www.kernel.org/pub/linux/kernel/projects/rt/${K_BRANCH_ID}/${RT_FILE}"
## GCC:
GCC_FILE="enable_additional_cpu_optimizations_for_gcc.patch"
GCC_LINK="https://raw.github.com/graysky2/kernel_gcc_patch/master/${GCC_FILE}"
## loop-AES:
LA_VERS="3.7a"
LA_DIFF="kernel-${K_BRANCH_ID}.diff"
LA_NAME="loop-AES-v${LA_VERS}"
LA_FILE="${LA_NAME}.tar.bz2"
LA_LINK="http://downloads.sourceforge.net/project/loop-aes/loop-aes/v${LA_VERS}/${LA_FILE}"

DESCRIPTION="Full Linux ${K_BRANCH_ID} kernel sources with the PREEMPT_RT, loop-AES and GCC patches"
SRC_URI="${KERNEL_URI} ${RT_LINK} ${GCC_LINK} ${LA_LINK}"

RDEPEND=">=sys-devel/gcc-4.7"

KV_FULL="${PVR/_p/-${K_NAME}-}"
S="${WORKDIR}/linux-${KV_FULL}"

src_unpack() {
	for UNPACK in ${A} ; do
		if [[ ${UNPACK} != ${GCC_FILE} ]]; then
			unpack ${UNPACK}
		fi
	done
	mv "${WORKDIR}/linux-${K_BRANCH_ID}" "${S}"
}

src_prepare() {
	cd "${S}"

	EPATCH_COMMON_OPTS="-p1 -g1 -E --no-backup-if-mismatch"

	## linux:
	epatch "${WORKDIR}/patch-${PV%_p*}"

	## GCC:
	epatch "${DISTDIR}/${GCC_FILE}"

	## PREEMPT_RT:
	sed -ri "s|-rt${RT_VERS}|-${RT_VERS}|g" "${WORKDIR}/${RT_NAME}"
	sed -ri "s|localversion-rt|localversion-${K_NAME}|g" "${WORKDIR}/${RT_NAME}"
	epatch "${WORKDIR}/${RT_NAME}"

	## loop-AES:
	rm -v "${S}/drivers/block/loop.c" "${S}/include/linux/loop.h"
	epatch "${WORKDIR}/${LA_NAME}/${LA_DIFF}"

	sed -ri "s|EXTRAVERSION =*|EXTRAVERSION = -${K_NAME}|" "${S}/Makefile"
}

pkg_postinst(){
	ewarn
	ewarn "==[ EBUILD ]=========================================================="
	ewarn
	ewarn "  ${PN} are *not* supported by the Gentoo Kernel Project."
	ewarn "  Do *not* open bugs in Gentoo's bugzilla for this ebuild/package."
	ewarn "  If you need support for this ebuild, contact milomouse @ github.com."
	ewarn
	ewarn
	ewarn "==[ PATCHES ]========================================================="
	ewarn
	ewarn "  Support for PREEMPT_RT:"
	ewarn "    ${HOMEPAGE}"
	ewarn
	ewarn "  Support for loop-AES:"
	ewarn "    http://sourceforge.net/projects/loop-aes/"
	ewarn
	ewarn "  Support for GCC:"
	ewarn "    https://github.com/graysky2/kernel_gcc_patch"
	ewarn
	ewarn
	ewarn "==[ LOOP-AES ]========================================================"
	ewarn
	ewarn "  Do *not* build  'sys-fs/loop-aes'  against this package!!"
	ewarn "  Simply install the encrypted loop device support package:"
	ewarn
	ewarn "    emerge 'app-crypt/loop-aes-losetup'"
	ewarn
}

K_EXTRAEINFO="For more info on rt-sources and details on how to report problems, see: \
${HOMEPAGE}."
