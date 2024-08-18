#!/usr/bin/env bash

get_script_path() {
    local input_line="$1"
    local stripped_line
    local comment_removed_line
    local final_path

    # Remove 'source' or '.' only if they're at the beginning of the line, followed by any whitespace
    if [[ "$input_line" =~ ^[[:space:]]*(source|\.)[[:space:]]+ ]]; then
        stripped_line="${input_line#*[[:space:]]}"
        stripped_line="${stripped_line#*(source|\.)[[:space:]]}"
    else
        stripped_line="$input_line"
    fi

    # Remove anything after and including the first occurrence of a '#'
    comment_removed_line="${stripped_line%%#*}"

    # Trim leading and trailing spaces
    final_path="$(echo -e "${comment_removed_line}" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')"

    echo "$final_path"
}
