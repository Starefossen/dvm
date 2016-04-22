#!/usr/bin/env bash

set -e

function printUsage() {
  echo "$0: CMD PROGRAM [VERSION]"
  echo ""
  echo "Commands:"
  echo "    install    Install new version"
  echo "    list       List installed versions"
  echo "    use        Set active version"
}

function main() {
  local -r BIN_DIR=/usr/local/bin
  local -r CMD=$1
  local -r PROGRAM=$2
  local -r PROGRAM_NO_PREFIX=$(echo ${PROGRAM} | sed -e 's/docker-//g')
  local -r PROGRAM_API_URL="https://api.github.com/repos/docker/${PROGRAM_NO_PREFIX}"
  local -r VERSION=$3

  if [ -z ${PROGRAM} ]; then
    echo "Error: you didn't specify a program"
    printUsage $@
    exit 1
  fi

  case "${CMD}" in
    # Install new version
    install)

      if [ -z ${VERSION} ]; then
        echo "Version not specified!"
        exit 1
      fi

      local -r REPO=$(echo ${PROGRAM} | sed 's/docker-//g')

      if [ "${PROGRAM}" == "docker" ]; then
        local -r URL="https://get.docker.com/builds/Darwin/x86_64/docker-${VERSION}.tgz"
        curl -vL "${URL}" | tar xOz --strip-components=1 > "${PROGRAM}-${VERSION}"
      else
        if [ "${PROGRAM}" == "docker-machine" ]; then
          local -r URL="https://github.com/docker/${REPO}/releases/download/v${VERSION}/${PROGRAM}-Darwin-x86_64"
        elif [ "${PROGRAM}" == "docker-compose" ]; then
          local -r URL="https://github.com/docker/${REPO}/releases/download/${VERSION}/${PROGRAM}-Darwin-x86_64"
        else
          echo "Install of ${PROGRAM} is not supported!"
          exit 1
        fi

        curl -vL -o "${PROGRAM}-${VERSION}" "${URL}"
      fi

      chmod +x "${PROGRAM}-${VERSION}"

      sudo rm -v "${BIN_DIR}/${PROGRAM}"
      sudo mv "${PROGRAM}-${VERSION}" "${BIN_DIR}"
      sudo ln -vs "${BIN_DIR}/${PROGRAM}-${VERSION}" "${BIN_DIR}/${PROGRAM}"
      ;;

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
