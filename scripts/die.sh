#!/bin/bash -e

INIT_WORKDIR="$(pwd)"
TMPDIR="${TMPDIR:-/tmp}"
VERSION="3.01"
TOOL_DIR="${HOME}/ctf-tools"

_install(){
  if [ ! -e "${TMPDIR}/die_lin64_portable_${VERSION}.tar.gz" ]; then
    wget -q \
      "https://github.com/horsicq/DIE-engine/releases/download/${VERSION}/die_lin64_portable_${VERSION}.tar.gz" \
      -O "${TMPDIR}/die_lin64_portable_${VERSION}.tar.gz"
  fi

  tar xf "${TMPDIR}/die_lin64_portable_{VERSION}.tar.gz" \
    -C ${TOOL_DIR}
  sudo ln -sf ${TOOL_DIR}/die_lin64_portable/die.sh /usr/local/bin/die

}
_postprocess(){
  rm -f "${TMPDIR}/die_lin64_portable_${VERSION}.tar.gz"
}