#!/usr/bin/env bash

host="192.168.0.10";
mount_dir=~/Downloads/shared;

user=artemis;
pass=$(pass show Artemis/smb.artemis);

sudo mount -t cifs //$host/public $mount_dir -o rw,username=$user,password=$pass;

