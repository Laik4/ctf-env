#!/bin/bash -e

INIT_WORKDIR="$(pwd)"
TMPDIR="${TMPDIR:-/tmp}"
VERSION="3.02"
TOOL_DIR="${TOOL_DIR:-${HOME}/ctf-tools}"

_install(){
  if [ ! -e "${TMPDIR}/die_lin64_portable_${VERSION}.tar.gz" ]; then
    wget -q \
      "https://github.com/horsicq/DIE-engine/releases/download/${VERSION}/die_lin64_portable_${VERSION}.tar.gz" \
      -O "${TMPDIR}/die_lin64_portable_${VERSION}.tar.gz"
  fi

  tar xf "${TMPDIR}/die_lin64_portable_${VERSION}.tar.gz" \
    -C ${TOOL_DIR}
  sudo cat << EOF | sudo tee /usr/local/bin/die
#!/bin/bash
TOOL_DIR="${TOOL_DIR}"
DIE_DIR="\${TOOL_DIR}/die_lin64_portable"
export LD_LIBRARY_PATH="\${DIE_DIR}/base:\${LD_LIBRARY_PATH}"
\${DIE_DIR}/base/die \$*
EOF

}
_postprocess(){
  rm -f "${TMPDIR}/die_lin64_portable_${VERSION}.tar.gz"
}

if [ -e $(command -v die) ]; then
  _install
  _postprocess
fi
