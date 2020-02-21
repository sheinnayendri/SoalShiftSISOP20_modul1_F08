#! /bin/bash

cd /home/rapuyy/Downloads/tugas/prak1/no3

mkdir kenangan
mkdir duplicate

 > wget.log   
 > location.log 

for ((a=1; a<=28; a=a+1))
	do
	wget -a wget.log "https://loremflickr.com/320/240/cat" -O pdkt_kusuma_"$a".jpeg #rapuyy buat temp
#	cat rapuyy.txt >> wget.log
done

grep "Location" wget.log > location.log

readarray -t arr < location.log
flag=0
for((a=0; a<28; a=a+1)) 
do
	nomer=$(ls -1 kenangan | wc -l)
	nomer2=$(ls -1 duplicate | wc -l)
	flag=$((0))
	#echo ${arr[$a]}, $nomer ,$nomer2
	#echo pdkt_kusuma_"$(($a+1))".jpeg
	for((i=0; i<$a; i=i+1)) 
		do 
		#echo perbandingan["$(($a+1))"]dengan["$(($i+1))"]
		if [ $a -eq 0 ] 
			then mv pdkt_kusuma_1.jpeg kenangan/kenangan_1.jpeg
			
		
		elif [ "${arr[$a]}" == "${arr[$i]}" ] 
		then 
			flag=$((1))
			break
		elif [ "${arr[$i]}" == "((${arr[$i]}-1))" ]
			then
			flag=$((0))
		fi
	done
	
	if [ $flag -eq 0 ] 
	then 
		mv pdkt_kusuma_"$(($a+1))".jpeg kenangan_"$(($nomer+1))".jpeg
		#echo case1
	else 
		#echo case2
		mv pdkt_kusuma_"$(($a+1))".jpeg duplicate_"$(($nomer2+1))".jpeg
	fi

done

cat wget.log >> wget.log.bak
cat location.log >> location.log.bak
