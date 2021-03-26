#!/usr/bin/env bash

preg_quote()
{
    escaped="$1"

    # escape all backslashes first
    escaped="${escaped//\\/\\\\}"

    # escape slashes
    escaped="${escaped//\//\\/}"

    # escape asterisks
    escaped="${escaped//\*/\\*}"

    # escape full stops
    escaped="${escaped//./\\.}"

    # escape [ and ]
    escaped="${escaped//\[/\\[}"
    escaped="${escaped//\]/\\]}"

    # escape ^ and $
    escaped="${escaped//^/\\^}"
    escaped="${escaped//\$/\\\$}"

    # remove newlines
    escaped="${escaped//[$'\n']/\\n}"

    echo "$escaped"
}