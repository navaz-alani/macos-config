#! /bin/bash

prog="block"

usage() {
  echo "USAGE: ${prog} -[b|u] website"
  echo "blocks/unblocks a website using the /etc/hosts file."
  echo "entires for 'website' and 'www.website' are (un)?blocked."
  echo "DNS cache is flushed afterwards."
  exit 1
}

if [ $# -ne 2 ]; then
  usage
fi

hostsFile="/etc/hosts"
website=${2}

if [ $1 = "-b" ]; then
  echo "0.0.0.0 ${website}" >> ${hostsFile}
  echo "0.0.0.0 www.${website}" >> ${hostsFile}
  # flush dns cache by OS
  if [ "$(uname)" = "Darwin" ]; then
    sudo killall -HUP mDNSResponder
  fi
elif [ $1 = "-u" ]; then
  tmp=$(mktemp)
  egrep -v "0.0.0.0 (www.)?${website}" < ${hostsFile} > ${tmp}
  tee < ${tmp} > ${hostsFile}
  rm ${tmp}
else
  usage
fi

