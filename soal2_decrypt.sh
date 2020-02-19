#!/bin/bash

awal="$(cut -d'.' -f1 <<<"$1")"
nama="$(cut -d'_' -f1 <<<"$awal")"
hour=`date +"%H"`
awal="$(cut -d'.' -f1 <<<"$1")"
hour="$(cut -d'_' -f2 <<<"$awal")"

CONV=("tr 'a-zA-Z' 'a-zA-Z'"
	"tr 'b-za-aB-ZA-A' 'a-zA-Z'"
	"tr 'c-za-bC-ZA-B' 'a-zA-Z'"
	"tr 'd-za-cD-ZA-C' 'a-zA-Z'"
	"tr 'e-za-dE-ZA-D' 'a-zA-Z'"
	"tr 'f-za-eF-ZA-E' 'a-zA-Z'"
	"tr 'g-za-fG-ZA-F' 'a-zA-Z'"
	"tr 'h-za-gH-ZA-G' 'a-zA-Z'"
	"tr 'i-za-hI-ZA-H' 'a-zA-Z'"
	"tr 'j-za-iJ-ZA-I' 'a-zA-Z'"
	"tr 'k-za-jK-ZA-J' 'a-zA-Z'"
	"tr 'l-za-kL-ZA-K' 'a-zA-Z'" 
	"tr 'm-za-lM-ZA-L' 'a-zA-Z'"
	"tr 'n-za-mN-ZA-M' 'a-zA-Z'"
	"tr 'o-za-nO-ZA-N' 'a-zA-Z'"
	"tr 'p-za-oP-ZA-O' 'a-zA-Z'"	
	"tr 'q-za-pQ-ZA-P' 'a-zA-Z'"
	"tr 'r-za-qR-ZA-Q' 'a-zA-Z'"
	"tr 's-za-rS-ZA-R' 'a-zA-Z'"
	"tr 't-za-sT-ZA-S' 'a-zA-Z'"
	"tr 'u-za-tU-ZA-T' 'a-zA-Z'"
	"tr 'v-za-uV-ZA-U' 'a-zA-Z'"
	"tr 'w-za-vW-ZA-V' 'a-zA-Z'"
	"tr 'x-za-wX-ZA-W' 'a-zA-Z'"
	"tr 'y-za-xY-ZA-X' 'a-zA-Z'"
	"tr 'z-za-yZ-ZA-Y' 'a-zA-Z'")

namaawal=$(echo $nama | ${CONV[$hour]})
echo "Original file name: "$namaawal".txt"

