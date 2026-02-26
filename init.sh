#!/bin/bash
set -e
cd "$(dirname "$0")" || exit 1
apt update -y
apt install vim sudo -y
./newuser.sh
