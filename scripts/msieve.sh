#!/bin/bash -e

VERSION="1.53"
INIT_WORKDIR="$(pwd)"
TMPDIR="${TMPDIR:-/tmp}"


_prerequisite(){
  sudo apt-get update
  sudo apt-get install -y build-essential libgmp3-dev zlib1g-dev libecm-dev
}
_install(){
  cd ${TMPDIR}
  if [ ! -e "${TMPDIR}/msieve.tar.gz" ]; then
    wget -q "https://altushost-swe.dl.sourceforge.net/project/msieve/msieve/Msieve%20v${VERSION}/msieve${VERSION/./}_src.tar.gz" -O "msieve.tar.gz"
  fi
  tar xf msieve.tar.gz
  cd msieve-${VERSION}/
  make all ECM=1
  sudo mv msieve /usr/local/bin/msieve
}
_postprocess(){
  rm -rf ${TMPDIR}/msieve-${VERSION}
  rm -f msieve.tar.gz
  cd ${INIT_WORKDIR}
}

if [ ! $(command -v msieve) ]; then
  _prerequisite
  _install
  _postprocess
fi
