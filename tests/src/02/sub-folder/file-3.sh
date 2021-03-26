#!/usr/bin/env bash

echo "file 3 here!"

current_dir=$(dirname "${BASH_SOURCE[0]}")
source "$current_dir/sub-folder/file-4.sh"