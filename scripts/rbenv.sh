#!/bin/bash

RUBY_STABLE_VERSION="2.7.4"
RUBY_LATEST_VERSION="3.0.2"
RBENV_ROOT=${HOME}/.rbenv
PATH=${RBENV_ROOT}/bin:${PATH}

_preprocess() {
  sudo apt-get update
  sudo apt-get install -y autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev

  cd "${RBENV_ROOT}" && src/configure && make -C src
  git clone "https://github.com/rbenv/rbenv.git" "${RBENV_ROOT}"
  echo 'export PATH="${RBENV_ROOT}/bin:${PATH}"' >>"${HOME}/.profile"
  echo 'eval "$(rbenv init - bash)"' >>$"${HOME}/.bashrc"
  eval "$(rbenv init - bash)"
  "${RBENV_ROOT}/bin/rbenv" init
  mkdir -p "$(rbenv root)/plugins"
  git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)/plugins/ruby-build"
}
_ruby_stable() {
  rbenv install "${RUBY_STABLE_VERSION}"
}
_ruby_latest() {
  rbenv install "${RUBY_LATEST_VERSION}"
}
_postprocess() {
  rbenv global "${RUBY_STABLE_VERSION}" "${RUBY_LATEST_VERSION}"
  rbenv rehash
}

# nodenv
if [ ! -e "${RBENV_ROOT}" ]; then
  _preprocess
else
  echo "[!] rbenv is already installed. Skipped."
fi

# Node.js Stable
if [ ! -e "${RBENV_ROOT}/versions/${RUBY_STABLE_VERSION}" ]; then
  _ruby_stable
else
  echo "[!] Ruby ${RUBY_STABLE_VERSION} is already installed. Skipped."
fi

# Node.js Latest
if [ ! -e "${RBENV_ROOT}/versions/${RUBY_LATEST_VERSION}" ]; then
  _ruby_latest
else
  echo "[!] Ruby ${RUBY_LATEST_VERSION} is already installed. Skipped."
fi

_postprocess
