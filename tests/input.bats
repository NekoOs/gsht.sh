#!/usr/bin/env bats

input() {
  source ../src/input.sh "$@"

  declare -p Input__help Input__version Input__verbose Input__watch Input__in_file Input__out_file Input__extra_args
}

@test "Check --help option" {
  run input --help
  eval "$output"
  [ "$status" -eq 0 ]
  [ "$Input__help" -eq 1 ]
  [ "$Input__version" -eq 0 ]
  [ "$Input__verbose" -eq 0 ]
  [ "$Input__watch" -eq 0 ]
  [ "$Input__in_file" = "" ]
  [ "$Input__out_file" = "" ]
  [ "${Input__extra_args[*]}" = "" ]
}

@test "Check --version option" {
  run input --version
  eval "$output"
  [ "$status" -eq 0 ]
  [ "$Input__help" -eq 0 ]
  [ "$Input__version" -eq 1 ]
  [ "$Input__verbose" -eq 0 ]
  [ "$Input__watch" -eq 0 ]
  [ "$Input__in_file" = "" ]
  [ "$Input__out_file" = "" ]
  [ "${Input__extra_args[*]}" = "" ]
}

@test "Check --verbose option" {
  run input --verbose
  eval "$output"
  [ "$status" -eq 0 ]
  [ "$Input__help" -eq 0 ]
  [ "$Input__version" -eq 0 ]
  [ "$Input__verbose" -eq 1 ]
  [ "$Input__watch" -eq 0 ]
  [ "$Input__in_file" = "" ]
  [ "$Input__out_file" = "" ]
  [ "${Input__extra_args[*]}" = "" ]
}

@test "Check --watch option" {
  run input --watch
  eval "$output"
  [ "$status" -eq 0 ]
  [ "$Input__help" -eq 0 ]
  [ "$Input__version" -eq 0 ]
  [ "$Input__verbose" -eq 0 ]
  [ "$Input__watch" -eq 1 ]
  [ "$Input__in_file" = "" ]
  [ "$Input__out_file" = "" ]
  [ "${Input__extra_args[*]}" = "" ]
}

@test "Check --input option" {
  run input --input example.txt
  eval "$output"
  [ "$status" -eq 0 ]
  [ "$Input__help" -eq 0 ]
  [ "$Input__version" -eq 0 ]
  [ "$Input__verbose" -eq 0 ]
  [ "$Input__watch" -eq 0 ]
  [ "$Input__in_file" = "example.txt" ]
  [ "$Input__out_file" = "" ]
  [ "${Input__extra_args[*]}" = "" ]
}

@test "Check --output option" {
  run input --output output.txt
  eval "$output"
  [ "$status" -eq 0 ]
  [ "$Input__help" -eq 0 ]
  [ "$Input__version" -eq 0 ]
  [ "$Input__verbose" -eq 0 ]
  [ "$Input__watch" -eq 0 ]
  [ "$Input__in_file" = "" ]
  [ "$Input__out_file" = "output.txt" ]
  [ "${Input__extra_args[*]}" = "" ]
}

@test "Check extra arguments" {
  run input --input example.txt -- extra1 extra2
  eval "$output"
  [ "$status" -eq 0 ]
  [ "$Input__help" -eq 0 ]
  [ "$Input__version" -eq 0 ]
  [ "$Input__verbose" -eq 0 ]
  [ "$Input__watch" -eq 0 ]
  [ "$Input__in_file" = "example.txt" ]
  [ "$Input__out_file" = "" ]
  [ "${Input__extra_args[*]}" = "extra1 extra2" ]
}

@test "Check combined options" {
  run input --input example.txt --output output.txt --verbose --watch --help --version -- extra1 extra2
  eval "$output"
  [ "$status" -eq 0 ]
  [ "$Input__help" -eq 1 ]
  [ "$Input__version" -eq 1 ]
  [ "$Input__verbose" -eq 1 ]
  [ "$Input__watch" -eq 1 ]
  [ "$Input__in_file" = "example.txt" ]
  [ "$Input__out_file" = "output.txt" ]
  [ "${Input__extra_args[*]}" = "extra1 extra2" ]
}

@test "Check missing input argument" {
  run input --input
  [ "$status" -eq 2 ]

  # Since we're expecting an error, we don't evaluate the output
  [[ "$output" == *"option '--input' requires an argument"* ]]
}

@test "Check missing output argument" {
  run input --output
  [ "$status" -eq 2 ]

  # Since we're expecting an error, we don't evaluate the output
  [[ "$output" == *"option '--output' requires an argument"* ]]
}

@test "Check invalid option" {
  run input --invalid
  [ "$status" -ne 0 ]

  # Since we're expecting an error, we don't evaluate the output
  [[ "$output" == *"unrecognized option '--invalid'"* ]]
}

