cd log
echo "analysis,h,CPUtime,Nruns,Nfail,fabs,frel,xabs,xrel,seed,under3460,under3450,under3440" > result.csv
for filename in *.log
do
  echo -n "${filename%.*}," >> result.csv
  grep -E -o "hmax = [0-9]*," $filename | sed 's/^.//g' | sed 's/[ ,:=a-z]//g' > temp.txt
  echo -n "$(cat temp.txt)," >> result.csv
  cd ../out
  grep -E -o "Elapsed time: [0-9]*.[0-9]*" "${filename%.*}".out | sed 's/^.//g' | sed 's/[ :A-Za-z]//g' > temp.txt
  echo -n "$(cat temp.txt)," >> ../log/result.csv
  cd ../log
  grep -E -o '[0-9]* runs' $filename | sed 's/[ a-z]//g' > temp.txt
  echo -n "$(cat temp.txt)," >> result.csv
  grep -E -o 'max number of failed proposals = [0-9]*'  $filename | sed 's/[ a-z=]//g' > temp.txt
  echo -n "$(cat temp.txt)," >> result.csv
  grep -E -o "ftolAbs=[0-9.e-]*," $filename | sed 's/[ ,ftolAbs=]//g' > temp.txt
  echo -n "$(cat temp.txt)," >> result.csv
  grep -E -o "ftolRel=[0-9.e-]*," $filename | sed 's/[ ,ftolRel=]//g' > temp.txt
  echo -n "$(cat temp.txt)," >> result.csv
  grep -E -o "xtolAbs=[0-9.e-]*" $filename | sed 's/[ xtolAbs=]//g' > temp.txt
  echo -n "$(cat temp.txt)," >> result.csv
  grep -E -o "xtolRel=[0-9]*.[0-9]*" $filename | sed 's/[ xtolRel=]//g' > temp.txt
  echo -n "$(cat temp.txt)," >> result.csv
  grep -E -o "main seed [0-9]*" $filename | sed 's/[ a-z]//g' > temp.txt
  echo -n "$(cat temp.txt)," >> result.csv
  grep -E -o "loglik of best [0-9]*" $filename | sed 's/[ a-z]//g' > t1.txt
  a=0
  b=0
  c=0
  for i in $(cat t1.txt)
  do
    if [ $i -lt 3440 ] # comment: need spaces next to the the square brackets
    then
      ((a=a+1))
      ((b=b+1))
      ((c=c+1))
    elif [ $i -lt 3450 ]
    then
      ((a=a+1))
      ((b=b+1))
    elif [ $i -lt 3460 ]
    then
      ((a=a+1))
    fi
  done
  echo $a > t2.txt
  echo -n "$(cat t2.txt)," >> result.csv
  echo $b > t2.txt
  echo -n "$(cat t2.txt)," >> result.csv
  echo $c > t2.txt
  echo -n "$(cat t2.txt)," >> result.csv
  echo >> result.csv
done
cd ../out
rm temp.txt
cd ../log
rm temp.txt
rm t1.txt
rm t2.txt
mv result.csv ../result.csv
cd ..
