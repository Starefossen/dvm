#!/usr/bin/env bash

set -e

function printUsage() {
  echo "$0: CMD PROGRAM [VERSION]"
  echo ""
  echo "Commands:"
  echo "    list       List installed versions"
  echo "    use        Set active version"
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
    # List installed versions
    list)
      local -r link=$(readlink "${BIN_DIR}/${PROGRAM}")

      for version in "${BIN_DIR}/${PROGRAM}-"?.*.*; do
        if [ "${version}" == "${link}" ]; then
          echo "$(basename ${version}) *"
        else
          echo "$(basename ${version})"
        fi
      done

      exit 0
      ;;

    # Set active version
    use)
      # @TODO check ${VERSION}

      # Prevent removing binary file
      if ! [ -L "${BIN_DIR}/${PROGRAM}" ]; then
        echo "${BIN_DIR}/${PROGRAM} should be a symlink"
        exit 1
      fi

      # Remove existing symbolic link
      if [ -L "${BIN_DIR}/${PROGRAM}" ]; then
        sudo rm -v "${BIN_DIR}/${PROGRAM}"
      fi

      sudo ln -vs "${BIN_DIR}/${PROGRAM}-${VERSION}" "${BIN_DIR}/${PROGRAM}"

      exit 0
      ;;
    *)
      printUsage $0
      exit 1
      ;;
  esac
}

main $@
