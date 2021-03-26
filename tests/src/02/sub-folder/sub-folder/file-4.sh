#!/usr/bin/env bash

echo "file 4 here!"

current_dir=$(dirname "${BASH_SOURCE[0]}")
source "$current_dir/../../file-2.sh"