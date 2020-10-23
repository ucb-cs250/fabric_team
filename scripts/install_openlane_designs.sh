#!/bin/bash

SCRIPT_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
DESIGN_ROOT="$(readlink -f "${SCRIPT_DIR}/..")"
INSTALL_DIR="$(readlink -f "${DESIGN_ROOT}/..")"

MAC_INSTALL_DIR="${INSTALL_DIR}/250_mac"
if [ ! -h "${MAC_INSTALL_DIR}" ]; then
  rm -rf "${MAC_INSTALL_DIR}"
  ln -s "250/mac_team/asic_config" "${MAC_INSTALL_DIR}"
fi

SRAM_INSTALL_DIR="${INSTALL_DIR}/250_sram"
if [ ! -h "${SRAM_INSTALL_DIR}" ]; then
  rm -rf "${SRAM_INSTALL_DIR}"
  ln -s "250/sram_team/asic_config" "${SRAM_INSTALL_DIR}"
fi

CLB_INSTALL_DIR="${INSTALL_DIR}/250_clb"
if [ ! -h "${CLB_INSTALL_DIR}" ]; then
  rm -rf "${CLB_INSTALL_DIR}"
  ln -s "250/clb_team/asic_config" "${CLB_INSTALL_DIR}"
fi
