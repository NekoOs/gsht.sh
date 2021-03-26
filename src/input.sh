#!/usr/bin/env bash

# Fork from https://gist.github.com/kaushalmodi/74e9875d5ab0a2bc1010447f1bee5d0a

# Initialize variables
Input__help=0
Input__verbose=0
Input__version=0
Input__out_file=
Input__in_file=
Input__extra_args=()

getopt --test > /dev/null
if [[ $? -ne 4 ]]; then
    echo "I'm sorry, 'getopt --test' failed in this environment."
    exit 1
fi

SHORT=hvVi:o:
LONG=help,version,verbose,input:,output:

PARSED=$(getopt --options ${SHORT} \
                --longoptions ${LONG} \
                --name "$0" \
                -- "$@")         #Pass all the args to this script to getopt

if [[ $? -ne 0 ]]; then
    exit 2
fi

eval set -- "${PARSED}"

while [[ $# -gt 0 ]]
do
    case "$1" in
        -h|--help)
            Input__help=1
            ;;
        -v|--version)
            Input__version=1
            ;;
        -V|--verbose)
            Input__verbose=1
            ;;
        -o|--output)
            Input__out_file="$2";
            shift
            ;;
        -i|--input)
            Input__in_file="$2";
            shift
            ;;
        --)
            shift
            Input__extra_args=("$@");
            break
            ;;
    esac
    shift
done
