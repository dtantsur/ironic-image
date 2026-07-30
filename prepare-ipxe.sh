#!/bin/bash
#
# prepare-ipxe copies the right images to /tftpboot, later when the
# shared volume is created, rundnsmasq will copy them there to
# /shared/tftpboot. We do this as a two-step operation to ensure all
# the expected images are available at build-time. Otherwise the CI
# jobs that build these images could succeed, but provisioning
# will actually fail without the images present.
#
# The target filenames must match the SNP_BASENAME convention used by
# copy_ipxe_firmware() in ironic-common.sh and dnsmasq.conf.j2:
#   <SNP_BASENAME>-x86_64.efi / <SNP_BASENAME>-arm64.efi
# SNP_BASENAME defaults to "snponly".

set -ex

mkdir -p /tftpboot

cp /usr/share/ipxe/undionly.kpxe /tftpboot/
cp /usr/share/ipxe/ipxe-snponly-x86_64.efi /tftpboot/snponly-x86_64.efi
cp /usr/share/ipxe/arm64-efi/snponly.efi /tftpboot/snponly-arm64.efi
