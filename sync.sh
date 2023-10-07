#!/bin/zsh
exclude()
{	
	flag=0
	while read -r text;
	do
		text=$(printf "%s" "$text" | sed "s/$2.*$3//g")
		result=$(printf "%s" "$text" | grep "$2")
		if [ "$result" ] ; then
			flag=1
		fi
		if [ $flag = 0 ] ; then
			printf "%s\n" "$text" >> "$4"
		fi
		result=$(printf "%s" "$text" | grep "$3")
		if [ "$result" ] ; then
			flag=0
		fi
	done < $1
}
filename=${1##*/}
path=${1%/*}
fpath=${path##*/}
if [ $fpath = "solution" ] ; then
	spath="${path%/*}/problem/"
	rm $spath$filename
	exclude $1 "\\\begin{solution}" "\\\end{solution}" "$spath$filename"
fi
