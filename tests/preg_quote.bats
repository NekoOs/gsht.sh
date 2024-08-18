#!/usr/bin/env bats

load ../src/preg_quote.sh

@test "Escape slashes" {
  result="$(preg_quote "path/to/file")"
  echo "$result"
  [ "$result" = 'path\/to\/file' ]
}

@test "Escape asterisks" {
  result="$(preg_quote "file*name")"
  echo "$result"
  [ "$result" = 'file\*name' ]
}

@test "Escape dots" {
  result="$(preg_quote "file.name")"
  echo "$result"
  [ "$result" = 'file\.name' ]
}

@test "Escape brackets" {
  result="$(preg_quote "[abc]")"
  echo "$result"
  [ "$result" = '\[abc\]' ]
}

@test "Escape special characters" {
  result="$(preg_quote "^start$ &end")"
  echo "$result"
  [ "$result" = '\^start\$ \&end' ]
}

@test "Escape newlines" {
  result="$(preg_quote "line1\nline2")"
  echo "$result"
  [ "$result" = 'line1\\nline2' ]
}

@test "Empty string" {
  result="$(preg_quote "")"
  echo "$result"
  [ "$result" = '' ]
}

@test "Escape complex combinations" {
  result="$(preg_quote "path/to/file.ext *[test]")"
  echo "$result"
  [ "$result" = 'path\/to\/file\.ext \*\[test\]' ]
}
