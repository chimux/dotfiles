#!/usr/bin/env zsh

min=1
max=51
num=1
actor=$(($RANDOM % ($max - $min + 1) + $min))
minute=$(date +%M)
HOME_COW="/opt/homebrew/bin"
HOME_RUBY="/opt/homebrew/opt/ruby/bin"

for cow in $("$HOME_COW/cowsay" -l); do
  if [ $num = $actor ]; then
    vaca="$cow"
  fi
  num=$((num + 1))
done

quote() {
  setopt localoptions nopromptsubst
  local data
  data="$(command curl -s --connect-timeout 2 "https://www.quotationspage.com/random.php" |
    iconv -c -f ISO-8859-1 -t UTF-8 |
    command grep -a -m 1 'dt class="quote"')"
  [[ -n "$data" ]] || return 0
  local quote author
  quote=$(sed -e 's|</dt>.*||g' -e 's|.*html||g' -e 's|^[^a-zA-Z]*||' -e 's|</a..*$||g' <<<"$data")
  author=$(sed -e 's|.*/quotes/||g' -e 's|<.*||g' -e 's|.*">||g' <<<"$data")
  print -P "%F{3}${author}%f: “%F{5}${quote}%f”"
}

if [ $(expr $minute % 2) -eq "0" ]; then
  artii -f small "C L O U D E R A" | lolcat
  quote | cowsay -f $vaca | lolcat
else
  artii -f ogre "C L O U D E R A" | lolcat
  fortune | cowsay -f $vaca | lolcat
fi


echo $vaca | lolcat
