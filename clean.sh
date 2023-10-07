cd /home/dirichy/homework
find . -name "*.aux" | xargs rm -f
find . -name "*.bbl" | xargs rm -f
find . -name "*.blg" | xargs rm -f
find . -name "*.idx" | xargs rm -f
find . -name "*.ind" | xargs rm -f
find . -name "*.lof" | xargs rm -f
find . -name "*.lot" | xargs rm -f
find . -name "*.out" | xargs rm -f
find . -name "*.toc" | xargs rm -f
find . -name "*.acn" | xargs rm -f
find . -name "*.acr" | xargs rm -f
find . -name "*.alg" | xargs rm -f
find . -name "*.glg" | xargs rm -f
find . -name "*.glo" | xargs rm -f
find . -name "*.gls" | xargs rm -f
find . -name "*.ist" | xargs rm -f
find . -name "*.fls" | xargs rm -f
find . -name "*.log" | xargs rm -f
find . -name "*.fdb_latexmk" | xargs rm -f
find . -name "*.gz" | xargs rm -f
read -r -p "Do you want delete pdfs? [y/N] " response
if [ "$response" = "y" ] ; then
 find . -name "*.pdf" | xargs rm -f
fi
