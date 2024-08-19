#!/usr/bin/env bats

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

assert_help_option() {
  [[ "$output" =~ Input__help=\"$1\" ]]
}
assert_version_option() {
  [[ "$output" =~ Input__version=\"$1\" ]]
}

assert_verbose_option() {
  [[ "$output" =~ Input__verbose=\"$1\" ]]
}

assert_watch_option() {
  [[ "$output" =~ Input__watch=\"$1\" ]]
}

assert_in_file_option() {
  [[ "$output" =~ Input__in_file=\"$1\" ]]
}

assert_out_file_option() {
  [[ "$output" =~ Input__out_file=\"$1\" ]]
}

assert_extra_args_option() {
  [[ "$output" =~ Input__extra_args="$1" ]]
}

@test "Check --help option" {
  run input --help
  [ "$status" -eq 0 ]

  assert_help_option 1
  assert_version_option 0
  assert_verbose_option 0
  assert_watch_option 0
  assert_in_file_option ''
  assert_out_file_option ''
  assert_extra_args_option '()'
}

@test "Check --version option" {
  run input --version
  [ "$status" -eq 0 ]

  assert_help_option 0
  assert_version_option 1
  assert_verbose_option 0
  assert_watch_option 0
  assert_in_file_option ''
  assert_out_file_option ''
  assert_extra_args_option '()'
}

@test "Check --verbose option" {
  run input --verbose
  [ "$status" -eq 0 ]

  assert_help_option 0
  assert_version_option 0
  assert_verbose_option 1
  assert_watch_option 0
  assert_in_file_option ''
  assert_out_file_option ''
  assert_extra_args_option ''
}

@test "Check --watch option" {
  run input --watch
  [ "$status" -eq 0 ]

  assert_help_option 0
  assert_version_option 0
  assert_verbose_option 0
  assert_watch_option 1
  assert_in_file_option ''
  assert_out_file_option ''
  assert_extra_args_option ''
}

@test "Check --input option" {
  run input --input example.txt
  [ "$status" -eq 0 ]

  assert_help_option 0
  assert_version_option 0
  assert_verbose_option 0
  assert_watch_option 0
  assert_in_file_option 'example.txt'
  assert_out_file_option ''
  assert_extra_args_option ''
}

@test "Check --output option" {
  run input --output output.txt
  [ "$status" -eq 0 ]

  assert_help_option 0
  assert_version_option 0
  assert_verbose_option 0
  assert_watch_option 0
  assert_in_file_option ""
  assert_out_file_option 'output.txt'
  assert_extra_args_option ""
}

@test "Check extra arguments" {
  run input --input example.txt -- extra1 extra2
  [ "$status" -eq 0 ]

  assert_help_option 0
  assert_version_option 0
  assert_verbose_option 0
  assert_watch_option 0
  assert_in_file_option 'example.txt'
  assert_out_file_option ''
  assert_extra_args_option '([0]="extra1" [1]="extra2")'
}

@test "Check combined options" {
  run input --input example.txt --output output.txt --verbose --watch --help --version -- extra1 extra2
  [ "$status" -eq 0 ]

  assert_help_option 1
  assert_version_option 1
  assert_verbose_option 1
  assert_watch_option 1
  assert_in_file_option 'example.txt'
  assert_out_file_option 'output.txt'
  assert_extra_args_option '([0]="extra1" [1]="extra2")'
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
