#!/bin/bash

nama="$(cut -d'.' -f1 <<<"$1")"
hour=`date +"%H"`

CONV=("tr 'a-zA-Z' 'a-zA-Z'"
	"tr 'a-zA-Z' 'b-za-aB-ZA-A'"
	"tr 'a-zA-Z' 'c-za-bC-ZA-B'"
	"tr 'a-zA-Z' 'd-za-cD-ZA-C'"
	"tr 'a-zA-Z' 'e-za-dE-ZA-D'"
	"tr 'a-zA-Z' 'f-za-eF-ZA-E'"
	"tr 'a-zA-Z' 'g-za-fG-ZA-F'"
	"tr 'a-zA-Z' 'h-za-gH-ZA-G'"
	"tr 'a-zA-Z' 'i-za-hI-ZA-H'"
	"tr 'a-zA-Z' 'j-za-iJ-ZA-I'"
	"tr 'a-zA-Z' 'k-za-jK-ZA-J'"
	"tr 'a-zA-Z' 'l-za-kL-ZA-K'" 
	"tr 'a-zA-Z' 'm-za-lM-ZA-L'"
	"tr 'a-zA-Z' 'n-za-mN-ZA-M'"
	"tr 'a-zA-Z' 'o-za-nO-ZA-N'"
	"tr 'a-zA-Z' 'p-za-oP-ZA-O'"	
	"tr 'a-zA-Z' 'q-za-pQ-ZA-P'"
	"tr 'a-zA-Z' 'r-za-qR-ZA-Q'"
	"tr 'a-zA-Z' 's-za-rS-ZA-R'"
	"tr 'a-zA-Z' 't-za-sT-ZA-S'"
	"tr 'a-zA-Z' 'u-za-tU-ZA-T'"
	"tr 'a-zA-Z' 'v-za-uV-ZA-U'"
	"tr 'a-zA-Z' 'w-za-vW-ZA-V'"
	"tr 'a-zA-Z' 'x-za-wX-ZA-W'"
	"tr 'a-zA-Z' 'y-za-xY-ZA-X'"
	"tr 'a-zA-Z' 'z-za-yZ-ZA-Y'")

namabaru=$(echo $nama | ${CONV[$hour]})
namafix=$namabaru\_$hour

(< /dev/urandom tr -dc A-Za-z0-9 | head -c28;) > $namafix.txt

