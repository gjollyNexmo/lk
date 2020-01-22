#!/bin/bash

#set -e

#==========================================================================================

function print_url {
  absolute_file_path=$(readlink -f $repository_path$1)
  relative_file_path=${absolute_file_path#$repository_path}

  git_branch=$(git -C $repository_path rev-parse ${OPTION} HEAD)
  git_url=$(git -C $repository_path config --get remote.origin.url)
  git_repo=${git_url##*github.com/}
  git_repo=${git_url##*github.com:}
  repository_name=${git_repo%%.*}

  echo "https://github.com/${repository_name}/blob/${git_branch}/${relative_file_path}"
}

#==========================================================================================

POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
  -c|--commit)
  OPTION=" "
  shift # past flag
  ;;
  -C|--path)
  repository_path="$(readlink -f $2)/"
  shift # past argument
  shift # past value
  ;;
  -h|--help)
  echo $"Usage: $0 [-c] [-C REPOSITORY_PATH] FILE"
  exit 0
  ;;
  *)    # unknown option
  POSITIONAL+=("$1") # save it in an array for later
  shift # past argument
  ;;
esac
done

OPTION=${OPTION:-"--abbrev-ref"}
repository_path=${repository_path:-"$(pwd)/"}

print_url ${POSITIONAL[0]}

#==========================================================================================
