#!/usr/bin/env bash

rate_sx() {
  [[ ! -z "$2" ]] \
    && curl $2.rate.sx/$1 \
    || curl rate.sx/$1;
}

get_1() { cut -d' ' -f1; }
get_2() { cut -d' ' -f2; }

help() {
  echo "
::: Rate.sx repl :::
  btc: get graph for btc in usd
  btc inr: get graph for btc in inr
  1btc inr: print the value of 1btc in inr
  q: quit
";
}

help;

while true; do
  while IFS="" read -r -e -d $'\n' -p 'rate.sx $ ' command; do
    case "$(echo $command | get_1)" in
      q) exit 0 ;;
      *) rate_sx $command ;;
    esac;
  done;
done;

