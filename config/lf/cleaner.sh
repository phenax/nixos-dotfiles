#!/usr/bin/env sh

exec kitten icat --clear --stdin no --transfer-mode file </dev/null >/dev/tty
