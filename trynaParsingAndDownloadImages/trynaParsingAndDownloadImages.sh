#! /bin/bash

ID=0
count=1
regex='^(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]\.[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]$'
regex2='^(http?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]\.[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]$'

if [ -d ./Images ]
then
	rm -rf ./Images
fi

while read line
do
	mkdir -p ./Images/item$ID
	lim=0
	lim=$(echo $line | tr -dc ',' | wc -c)
	let lim++

	if [ $lim -gt 3 ]
	then
		lim=3
	fi

	for i in $(seq 1 $lim)
	do
		#echo $line | sed 's/"//' | cut -d ',' -f $i > ./Images/item$ID/url$ID-$count
		#wget -q -O- $(cat ./Images/item$ID/url$ID-$count) > ./Images/item$ID/url$ID-$count
		url=$(echo $line | sed 's/"//g' | cut -d ',' -f $i)
		if [[ $url != "" ]] && ([[ $url =~ $regex ]] || [[ $url =~ $regex2 ]])
		then
			wget -q -O- $url > ./Images/item$ID/url$ID-$count
			if [ $1 == "-v" ]
			then
				echo created image $ID-$count
			fi
		fi
		let count++
	done
	count=0
	let ID++
	if [ $1 == "-v" ]
	then
		echo -------------------------
	fi
done < ./realFile
