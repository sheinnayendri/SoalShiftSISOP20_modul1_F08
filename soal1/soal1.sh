#!/bin/bash

echo "Soal 1a:"
awk 'BEGIN { FS = "\t" } 
{ if( $13 != "Region" ) { a[$13] += $21 } } 
END { for(b in a) {print a[b], b} }' Sample-Superstore.tsv  | sort -g | head -1

echo ""
echo "Soal 1b:"
awk 'BEGIN { FS = "\t" } 
{ if( $13 == "Central" ) { a[$11] += $21 } } 
END { for(b in a) { print a[b], b } }' Sample-Superstore.tsv  | sort -g | head -2

echo ""
echo "Soal 1c:"
awk 'BEGIN { FS = "\t" }
{ if( $11 == "Texas" || $11 == "Illinois" ) { a[$17] += $21 } }
END { for(b in a) { print a[b], b } }' Sample-Superstore.tsv | sort -g | head -10

