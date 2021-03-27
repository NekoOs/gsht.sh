#!/usr/bin/env bash

die()
{
    echo "$1"
    exit "${2:-0}"
}