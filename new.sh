subject=$(grep -o '"'$1'":"[^"]*' subjects.json | grep -o '[^"]*$')
echo $subject
 if [ ! $subject ]; then  
  echo "Can't find given subject, please check subjects.json!"  
  exit 8
 fi
if [ ! -d "./"$subject"/" ]; then
 mkdir "./"$subject"/"
 cp global/default_template "./"$subject"/template"
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
cp "./"$subject"/"template "./$subject/$i/problem/$subject$i.tex"
code --goto "./$subject/$i/problem/$subject$i.tex":11:2
