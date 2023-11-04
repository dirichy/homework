subject=$(grep -o '"'$1'":"[^"]*' subjects.json | grep -o '[^"]*$')
echo $subject
if [ ! $subject ]; then
	echo "Can't find given subject, please check subjects.json!"
	exit 8
fi
if [ ! -d "./"$subject"/" ]; then
	mkdir "./"$subject"/"
	cp global/default_template "./$subject/template"
	cp global/default_localcommands "./$subject/localcommands"
	echo $subject >"./$subject/.subject"
	openfile="./$subject/template"
else
	path="./"$subject"/"
	i=1
	while [ -d "$path/$i" ]; do
		i=$(($i + 1))
	done
	mkdir "$path/$i"
	mkdir "$path/$i/problem"
	mkdir "$path/$i/solution"
	echo $i >"$path/$i/.number"
	cp "./"$subject"/"template "./$subject/$i/solution/$subject$i.tex"
	openfile="./$subject/$i/solution/$subject$i.tex"
fi
j=1
k=0
while read line; do
	j=$(($j + 1))
	if [ "$line" = "%from_here_to_type" ]; then
		k=$j
	fi
done <"$openfile"
#if [ k = 0 ]; then
#	code --goto "$openfile:16:1"
#else
#	code --goto "$openfile:$k:1"
#fi
