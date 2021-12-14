#! /bin/bash

regex='^(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]\.[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]$'
regex2='^(http?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]\.[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]$'
ID=1

rm ./checkInputResult
while read line
do
	lim=0
	lim=$(echo $line | tr -dc ',' | wc -c)
	let lim++
	echo Line $ID got $lim urls >> checkInputResult

	for i in $(seq 1 $lim)
	do
		url=$(echo $line | sed 's/"//g' | cut -d ',' -f $i)
		if [[ $url =~ $regex ]] || [[ $url == '' ]] || [[ $url =~ $regex2 ]]
		then 
				echo "$url IS valid" >> /dev/null
		else
				echo "$url IS NOT valid" >> checkInputResult
				echo $url >> notValidUrls
		fi
	done
	echo '' >> checkInputResult
	let ID++
done < ./realFile
