#!/usr/bin/env bats

load ../src/get_script_path.sh

@test "Line with 'source' at the start" {
  result="$(get_script_path "source /path/to/script.sh")"
  [ "$result" = '/path/to/script.sh' ]
}

@test "Line with 'source' and comments" {
  result="$(get_script_path "source /path/to/script.sh # this is a comment")"
  [ "$result" = '/path/to/script.sh' ]
}

@test "Line without 'source'" {
  result="$(get_script_path "/path/to/script.sh")"
  [ "$result" = '/path/to/script.sh' ]
}

@test "Line with only comments" {
  result="$(get_script_path "# this is a comment")"
  [ "$result" = '' ]
}

@test "'source' in the middle of the line" {
  result="$(get_script_path "/path/to/source script.sh")"
  [ "$result" = '/path/to/source script.sh' ]
}

@test "Empty line" {
  result="$(get_script_path "")"
  [ "$result" = '' ]
}

@test "Line with 'source' and tabs" {
  result="$(get_script_path "source	/path/to/script.sh")"
  [ "$result" = '/path/to/script.sh' ]
}

@test "Line with '.' notation" {
  result="$(get_script_path ". /path/to/script.sh")"
  [ "$result" = '/path/to/script.sh' ]
}

@test "Line with '.' notation and tabs" {
  result="$(get_script_path ".		/path/to/script.sh")"
  [ "$result" = '/path/to/script.sh' ]
}

@test "Line with 'source' and multiple spaces" {
  result="$(get_script_path "source   /path/to/script.sh")"
  [ "$result" = '/path/to/script.sh' ]
}

@test "Line with 'source' and comments after tabs" {
  result="$(get_script_path "source	/path/to/script.sh	# this is a comment")"
  [ "$result" = '/path/to/script.sh' ]
}

@test "Line with '.' and comments after spaces" {
  result="$(get_script_path ". /path/to/script.sh  # another comment")"
  [ "$result" = '/path/to/script.sh' ]
}
