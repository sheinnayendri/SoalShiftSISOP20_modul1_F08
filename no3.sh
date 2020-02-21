#! /bin/bash

mkdir /home/rapuyy/Downloads/tugas/prak1/no3/kenangan
mkdir /home/rapuyy/Downloads/tugas/prak1/no3/duplicate

 > /home/rapuyy/Downloads/tugas/prak1/no3/wget.log   
 > /home/rapuyy/Downloads/tugas/prak1/no3/location.log 

for ((a=1; a<=28; a=a+1))
	do
	wget -a /home/rapuyy/Downloads/tugas/prak1/no3/wget.log "https://loremflickr.com/320/240/cat" -O /home/rapuyy/Downloads/tugas/prak1/no3/pdkt_kusuma_"$a".jpeg
done

grep "Location" /home/rapuyy/Downloads/tugas/prak1/no3/wget.log > /home/rapuyy/Downloads/tugas/prak1/no3/location.log

readarray -t arr < /home/rapuyy/Downloads/tugas/prak1/no3/location.log
flag=0
for((a=0; a<28; a=a+1)) 
do
	nomer=$(ls -1 /home/rapuyy/Downloads/tugas/prak1/no3/kenangan | wc -l)
	nomer2=$(ls -1 /home/rapuyy/Downloads/tugas/prak1/no3/duplicate | wc -l)
	flag=$((0))
	#echo ${arr[$a]}, $nomer ,$nomer2 
	#echo pdkt_kusuma_"$(($a+1))".jpeg
	for((i=0; i<$a; i=i+1)) 
		do 
		#echo perbandingan["$(($a+1))"]dengan["$(($i+1))"]
		if [ $a -eq 0 ] 
			then mv /home/rapuyy/Downloads/tugas/prak1/no3/pdkt_kusuma_1.jpeg kenangan/kenangan_1.jpeg
			
		
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
		mv /home/rapuyy/Downloads/tugas/prak1/no3/pdkt_kusuma_"$(($a+1))".jpeg /home/rapuyy/Downloads/tugas/prak1/no3/kenangan/kenangan_"$(($nomer+1))".jpeg
		echo case1
	else 
		echo case2
		mv /home/rapuyy/Downloads/tugas/prak1/no3/pdkt_kusuma_"$(($a+1))".jpeg /home/rapuyy/Downloads/tugas/prak1/no3/duplicate/duplicate_"$(($nomer2+1))".jpeg
	fi

done
