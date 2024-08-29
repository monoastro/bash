#!/bin/sh
languages=$(echo "c cpp typescript nodejs python golang rust arduino lua" | tr ' ' '\n')
core_utils=$(echo "xargs find mv sed awk bash curl tmux" | tr ' ' '\n')

selected=$(printf "%s\n%s" "$languages" "$core_utils" | fzf)
read -p "Query: " query
if printf "%s" "$languages" | grep -q "$selected"; then
	query=$(echo "$query" | tr ' ' '+')
	curl -s cht.sh/$selected/$query | less -R
else
	curl -s cht.sh/$selected~$query | less -R
fi
