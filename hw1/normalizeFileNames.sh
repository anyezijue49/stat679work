cd ./log
for filename in *[123456789]_snaq.log
do
mv ./"$filename" "${filename:0:8}0${filename:8}"
done
cd ../out
for filename in *[123456789]_snaq.out
do
mv ./"$filename" "${filename:0:8}0${filename:8}"
done
cd ..
