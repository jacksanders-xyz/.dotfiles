#!/usr/bin/env bash
languages=`echo "javascript typscript lua python ruby golang nodejs kubectl vim nvim docker" | tr ' ' '\n'`
core_utils=`echo "xargs find mv sed awk pushd" | tr ' ' '\n'`
selected=`printf "$languages\n$core_utils" | fzf`
read -p "query: " query

if printf $languages | grep -qs $selected; then
  curl cht.sh/$selected/`echo $query | tr ' ' '+'`
else
  curl cht.sh/$selected~$query
fi
