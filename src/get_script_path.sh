#!/usr/bin/env bash

get_script_path() {
    local input_line="$1"
    local stripped_line
    local comment_removed_line
    local final_path

    # Remove 'source' only if it is at the beginning of the line, followed by a space
    if [[ "$input_line" =~ ^source[[:space:]]+ ]]; then
        stripped_line="${input_line#source }"
    else
        stripped_line="$input_line"
    fi

    # Remove anything after and including the first occurrence of a '#'
    comment_removed_line="${stripped_line%%#*}"

    # Trim any trailing spaces
    final_path="$(echo -e "${comment_removed_line}" | sed -e 's/[[:space:]]*$//')"

    echo "$final_path"
}
