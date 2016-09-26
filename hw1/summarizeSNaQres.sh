cd log
echo "analusis,h,CPUtime" > result.csv
for filename in *.log
do
echo -n ${filename%.*} >> result.csv
echo -n "," >> result.csv
grep hmax $filename | head -n 1 | tail -c 3 | head -c 1  > temp1.txt
echo -n "$(cat temp1.txt)" >> result.csv
echo -n "," >> result.csv
cd ../out
grep time "${filename%.*}".out | head -c 29 | tail -c 14 > temp2.txt
mv temp2.txt ../log/temp2.txt
cd ../log
echo -n "$(cat temp2.txt)" >> result.csv
echo >> result.csv
done
rm temp1.txt
rm temp2.txt
mv result.csv ../result.csv
