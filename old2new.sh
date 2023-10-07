subject=$(grep -o '"'$1'":"[^"]*' subjects.json | grep -o '[^"]*$')
echo $subject
if [ ! $subject ]; then  
 echo "Can't find given subject, please check subjects.json!"  
 exit 8
fi
echo $subject > "./$subject/.subject"
cp global/default_template "./$subject/template"
cp global/default_template "./$subject/localcommands"
openfile="./$subject/template"
path="./"$subject"/"
 i=1
 while [ -d "$path$i" ]
 do
  mkdir "$path$i/problem"
  mkdir "$path$i/solution"
  echo $i > "$path$i/.number"
  oldfile=$(find "$path$i" -name "*.tex")
  cp $oldfile "$path$i/solution/$subject$i.tex"
  sh sync.sh "$path$i/solution/$subject$i.tex"
  i=$(($i+1))
 done
