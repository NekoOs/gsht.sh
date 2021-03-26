#!/usr/bin/env bash

gsht()
{
    (
        source preg_quote.sh

        source console.sh
        source version.sh

        # Request

        source input.sh

        # Guard Clauses

        if [[ ${Input__version} -eq 1 ]]; then
            die "$(version)"
        fi

        if [[ ${Input__help} -eq 1 ]]; then
            die "$(version)"
        fi

        if [[ -z "$Input__in_file" && ${#Input__extra_args[@]} -eq 0  ]]; then
            die "input file is required." 1
        fi

        # Declare

        local line
        local out_dir
        local self="$0"
        local in_file="${Input__in_file:-${Input__extra_args[0]}}"
        local tmp_ext=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 13 ; echo '')
        local in_dir=$(dirname "$in_file")

        out_file=${out_dir:-.}/${Input__out_file:-$(basename "$in_file" .sh)}
        out_dir=$(dirname "$out_file")

        mkdir -p "$out_dir"

        cp ${in_file} ${out_file}

        grep -E "source\s(.*)(\..*)*$" ${in_file} | while read -r line; do

            local search="$line"
            local import=$(echo "$line" | sed 's/source\s\s*//g')

            ${self} --input "$in_dir/$import" --output "$in_dir/$import.$tmp_ext"

            local source=$(tail -n +2 "$in_dir/$import.$tmp_ext")

            rm "$in_dir/$import.$tmp_ext"

            local source_escaped=$(preg_quote "$source")
            local search_escaped=$(preg_quote "$search")

            sed -i 's/'"$search_escaped"'/'"$source_escaped"'/g' ${out_file}
        done

        if [[ ${Input__watch} -eq 1 ]]; then
            watch "${self} --input '$Input__in_file' --output='$Input__out_file'"
        fi
    )
}

gsht "$@"