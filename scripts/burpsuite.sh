#!/bin/bash

INITIAL_PATH="$(pwd)"
TMPDIR="${TMPDIR:-/tmp}"

_prerequisite(){
  sudo apt update 
  sudo apt install -y axel
}

_burpsuite(){
  local VERSION="2021.2.1"
  FILENAME="burpsuite_community_linux_v${VERSION//\./\_}"
  if [ ! -e ${TMPDIR}/${FILENAME}.sh ]; then
    axel -n 8 -v \
      -a "https://portswigger.net/burp/releases/download?product=community&version=${VERSION}&type=Linux" \
      -o ${TMPDIR}
  fi

  cd ${TMPDIR}
  bash ${FILENAME}.sh
}
_postprocessing(){
  rm ${FILENAME}.sh

  cd ${INIT_PATH}
}

_prerequisite
_burpsuite
_postprocessing
