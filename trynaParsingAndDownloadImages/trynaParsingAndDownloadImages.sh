#! /bin/bash

ID=0
count=1
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

	for i in $(seq 1 $lim)
	do
		echo $line | sed 's/"//' | cut -d ',' -f $i > ./Images/item$ID/url$ID-$count
		#cd Images/item$ID/
		#wget $line | sed 's/"//' | cut -d ',' -f $i
		let count++
		#cd ../../
	done
	count=0
	let ID++
done < exampleTextFile
