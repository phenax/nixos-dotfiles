#!/usr/bin/env bash

allow_proto_port() {
  sudo iptables -I INPUT -p $1 --dport $2 -j ACCEPT;
  sudo ip6tables -I INPUT -p $1 --dport $2 -j ACCEPT;
}

allow_port() {
  [[ $# != 1 ]] && echo "Invalid command: firewall allow <port>" && exit 1;
  allow_proto_port tcp $1;
  allow_proto_port udp $1;
}

restore_table() {
  sudo iptables-restore < ~/dump/iptables-backup;
}

cmd="$1"; shift;

case "$cmd" in
  allow) allow_port "$@" ;;
  restore) restore_table ;;
  *) echo "Invalid command" && exit 1 ;;
esac;

