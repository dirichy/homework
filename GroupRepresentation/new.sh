subject=${PWD##*/}
path=$(pwd)
i=1
while [ -d "$path/$i" ]
do
	i=$(($i+1))
done
mkdir $i
cp template ./$i/"$subject$i.tex"
code --goto ./$i/"$subject$i.tex":11:1

