#!/usr/bin/env bash

session_dir=$(mktemp -d /tmp/qb-sessionbox.XXXXX);

data=$session_dir/data;
config=$session_dir/config;

mkdir -p $config;
cp -r ~/.config/qutebrowser/* $config;

mkdir -p $data;
cp -r ~/.local/share/qutebrowser/* $data;

rm $data/sessions/default.yml
rm -rf $data/webengine;

qutebrowser --basedir $session_dir;

rm -rf $session_dir;
