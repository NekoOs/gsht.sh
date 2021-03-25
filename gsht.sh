#!/usr/bin/env bash

gsht()
{
    (
        source ./preg_quote.sh

        local temporal_extension=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 13 ; echo '')
        local line=""
        local script_filename=$1
        local temporal_output=${2:-src/$(basename $1 .sh)}
        local self="$0"

        mkdir -p bin

        if [[ ! -f "$script_filename" ]]; then
           exit 2
        fi

        local script_dir=$(dirname "$1")

        cp ${script_filename} ${temporal_output}

        grep -E "^source\s(.*)(\..*)*$" ${script_filename} | while read -r line; do

            local search="$line"
            local import=$(echo "$line" | sed 's/source\s\s*//g')

            ${self} "$script_dir/$import" "$script_dir/$import.$temporal_extension"

            local source=$(tail -n +2 "$script_dir/$import.$temporal_extension")

            rm "$script_dir/$import.$temporal_extension"

            local source_escaped=$(preg_quote "$source")
            local search_escaped=$(preg_quote "$search")

            sed 's/'"$search_escaped"'/'"$source_escaped"'/g' ${temporal_output} > ${temporal_output}.tmp
            mv -f ${temporal_output}.tmp ${temporal_output}
        done
    )
}

gsht "$@"