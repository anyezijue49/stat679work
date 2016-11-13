while read line
do
        if [ "${line}" -lt "450" ]
        then
                count=$((count+1))
        fi
done < t1.txt

echo ${count}
