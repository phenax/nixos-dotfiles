#!/usr/bin/env bash

name=$(echo -n "" | dmenu -p "tag name ::");

[[ ! -z "$name" ]] && dwmc settagname "$name";

