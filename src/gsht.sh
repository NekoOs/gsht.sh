#!/usr/bin/env bash

gsht()
{
    (
        source preg_quote.sh

        source console.sh
        source version.sh
        source get_script_path.sh

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
        local in_file
        local tmp_ext
        local in_dir

        in_file="${Input__in_file:-${Input__extra_args[0]}}"
        tmp_ext=$(tr -dc A-Za-z0-9 </dev/urandom 2>/dev/null | head -c 13 ; echo '')
        in_dir=$(dirname "$in_file")
        if [[ "${Input__out_file:0:1}" == "/" ]]; then
            out_file="${Input__out_file}"
        else
            out_file="${out_dir:-.}/${Input__out_file:-$(basename "$in_file" .sh)}"
        fi
        out_dir=$(dirname "$out_file")

        mkdir -p "$out_dir"

        cp "$in_file" "$out_file"

        grep -E "^\s*source\s.*$" "$in_file" | while read -r line; do

            local search
            local import
            local source
            local source_escaped
            local search_escaped

            search="$line"
            import=$(get_script_path "$line")

            ${self} --input "$in_dir/$import" --output "$in_dir/$import.$tmp_ext"

            source=$(tail -n +2 "$in_dir/$import.$tmp_ext")

            rm "$in_dir/$import.$tmp_ext"

            source_escaped=$(preg_quote "$source")
            search_escaped=$(preg_quote "$search")

            sed -i 's/'"$search_escaped"'/'"$source_escaped"'/g' "$out_file"
        done

        if [[ ${Input__watch} -eq 1 ]]; then
            watch "${self} --input '$Input__in_file' --output='$Input__out_file'"
        fi
    )
}

gsht "$@"