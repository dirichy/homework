subject=$(grep -o '"'$1'":"[^"]*' subjects.json | grep -o '[^"]*$')
echo $subject
 if [ ! $subject ]; then  
  echo "Can't find given subject, please check subjects.json!"  
  exit 8
 fi
if [ ! -d "./"$subject"/" ]; then
 mkdir "./"$subject"/"
 cp global/default_template "./"$subject"/template"
 echo $subject > "./$subject/.subject"
fi
path="./"$subject"/"
i=1
while [ -d "$path/$i" ]
do
	i=$(($i+1))
done
mkdir "$path/$i"
mkdir "$path/$i/problem"
mkdir "$path/$i/solution"
echo $i > "$path/$i/.number"
cp "./"$subject"/"template "./$subject/$i/problem/$subject$i.tex"
j=1
k=0
while read line
do
 j=$(($j+1))
 if [ "$line" = "%from_here_to_type" ] ; then
  k=$j
fi
done < "./$subject/$i/problem/$subject$i.tex"
if [ k = 0 ] ; then
 code --goto "./$subject/$i/problem/$subject$i.tex":16:1
else
 code --goto "./$subject/$i/problem/$subject$i.tex:$k:1"
fi