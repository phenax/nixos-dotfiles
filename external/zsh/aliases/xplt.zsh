export WORDLISTS=~/dev/xploits/wordlist;
export ROCK_YOU_WORDS="$WORDLISTS/rockyou.txt";
export URL_WORDS="$WORDLISTS/dirb/common.txt";
export URL_WORDS_MED="$WORDLISTS/dirb/dirbuster/directory-list-lowercase-2.3-medium.txt";

# metasploit
alias msfc="msfconsole --quiet -x \"db_connect postgres@msf\""
# exploitdb
alias ssplt="searchsploit"
alias sspx="searchsploit -x"

# Port scan
alias rmap="docker run -it --rm --name rustscan rustscan/rustscan:1.10.0"

# DVWA
alias dvwa="docker run --rm -it -p 80:80 vulnerables/web-dvwa"

# Directory search
alias crawl="gobuster dir -w $URL_WORDS"
alias crawl_strict="gobuster dir -w $URL_WORDS_MED"

new_room() {
  take ~/dev/xploits/temp/$1; nvim README.md;
}

jrock() {
  [[ "$#" != "2" ]] && echo "jrock (format) (hashfile)" && return 1;
  john -format="$1" "$2" -wordlist=$ROCK_YOU_WORDS;
}

hrock() {
  # Usage: hrock $mode $hashfile
  # mode - (1800 for sha512crypt $6$)
  [[ "$#" != "2" ]] && echo "hrock (mode-num) (hashfile)" && return 1;
  hashcat -m "$1" "$2" -o ./out $ROCK_YOU_WORDS --force;
}

hydra_ssh() {
  # Usage: hydra_ssh $username $ip
  [[ "$#" != "2" ]] && echo "hydru (username) (host)" && return 1;
  hydra -l $1 -P $ROCK_YOU_WORDS ssh://$2 -V;
}
hydra_post() {
  # Usage: hydra_post $username $ip $login-string
  # /login:username=^USER^&password=^PASS^:incorrect
  [[ "$#" != "2" ]] && echo "hydru (username) (host)" && return 1;
  hydra -l $1 -P $ROCK_YOU_WORDS $2 http-post-form "$3" -V;
}

ip_get() {
  # Usage: ip_get [$ip]
  curl https://json.geoiplookup.io/$1 | \
    jq '.ip + " | " + .asn + "(" + .district + ", " + .region + ")"';
}

