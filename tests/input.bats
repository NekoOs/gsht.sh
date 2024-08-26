#!/usr/bin/env bats

setup_file() {
    cd "$(dirname "$BATS_TEST_FILENAME")" || exit
}

input() {
  source ../src/input.sh "$@"

  declare -p \
    Input__help \
    Input__version \
    Input__verbose \
    Input__watch \
    Input__in_file \
    Input__out_file \
    Input__extra_args
}

assert_help_value() {
  [[ "$output" =~ Input__help=\"$1\" ]]
}
assert_version_value() {
  [[ "$output" =~ Input__version=\"$1\" ]]
}

assert_verbose_value() {
  [[ "$output" =~ Input__verbose=\"$1\" ]]
}

assert_watch_value() {
  [[ "$output" =~ Input__watch=\"$1\" ]]
}

assert_in_file_value() {
  [[ "$output" =~ Input__in_file=\"$1\" ]]
}

assert_out_file_value() {
  [[ "$output" =~ Input__out_file=\"$1\" ]]
}

assert_extra_args_value() {
  [[ "$output" =~ Input__extra_args="$1" ]]
}

assert_default_values() {
  local parameter
  for parameter in "$@"; do
    case "$parameter" in
      help) assert_help_value 0 ;;
      version) assert_version_value 0 ;;
      verbose) assert_verbose_value 0 ;;
      watch) assert_watch_value 0 ;;
      in_file) assert_in_file_value '' ;;
      out_file) assert_out_file_value '' ;;
      extra_args) assert_extra_args_value '()' ;;
    esac
  done
}

@test "Check --help option" {
  run input --help
  [ "$status" -eq 0 ]

  assert_help_value 1
  assert_default_values version verbose watch in_file out_file extra_args
}

@test "Check --version option" {
  run input --version
  [ "$status" -eq 0 ]

  assert_version_value 1
  assert_default_values help verbose watch in_file out_file extra_args
}

@test "Check --verbose option" {
  run input --verbose
  [ "$status" -eq 0 ]

  assert_verbose_value 1
  assert_default_values help version watch in_file out_file extra_args
}

@test "Check --watch option" {
  run input --watch
  [ "$status" -eq 0 ]

  assert_watch_value 1
  assert_default_values help version verbose in_file out_file extra_args
}

@test "Check --input option" {
  run input --input example.txt
  [ "$status" -eq 0 ]

  assert_in_file_value 'example.txt'
  assert_default_values help version verbose watch out_file extra_args
}

@test "Check --output option" {
  run input --output output.txt
  [ "$status" -eq 0 ]

  assert_out_file_value 'output.txt'
  assert_default_values help version verbose watch in_file extra_args
}

@test "Check extra arguments" {
  run input -- extra1 extra2
  [ "$status" -eq 0 ]

  assert_extra_args_value '([0]="extra1" [1]="extra2")'
  assert_default_values help version verbose watch in_file out_file
}

@test "Check combined options" {
  run input --input example.txt --output output.txt --verbose --watch --help --version -- extra1 extra2
  [ "$status" -eq 0 ]

  assert_help_value 1
  assert_version_value 1
  assert_verbose_value 1
  assert_watch_value 1
  assert_in_file_value 'example.txt'
  assert_out_file_value 'output.txt'
  assert_extra_args_value '([0]="extra1" [1]="extra2")'
}

@test "Check missing input argument" {
  run input --input
  [ "$status" -eq 2 ]
  [[ "$output" == *"option '--input' requires an argument"* ]]
}

@test "Check missing output argument" {
  run input --output
  [ "$status" -eq 2 ]
  [[ "$output" == *"option '--output' requires an argument"* ]]
}

@test "Check invalid option" {
  run input --invalid
  [ "$status" -ne 0 ]
  [[ "$output" == *"unrecognized option '--invalid'"* ]]
}
