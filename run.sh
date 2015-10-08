#!/usr/bin/env bash

set -e

function printUsage() {
  echo "$0: CMD PROGRAM [VERSION]"
}

function main() {
  local -r BIN_DIR=/usr/local/bin
  local -r CMD=$1
  local -r PROGRAM=$2
  local -r VERSION=$3

  if [ -z ${PROGRAM} ]; then
    echo "Error: you didn't specify a program"
    printUsage $@
    exit 1
  fi

  case "${CMD}" in
    *)
      printUsage $0
      exit 1
      ;;
  esac
}

main $@
