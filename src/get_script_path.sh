#!/usr/bin/env bash

get_script_path()
{
    local line
    line="$1"
    # shellcheck disable=SC2001
    import=$(echo "$line" | sed 's/source\s\s*//g')
    # shellcheck disable=SC2001
    import=$(echo "$import" | sed 's/\s*#.*$//g')
    echo "$import"
}