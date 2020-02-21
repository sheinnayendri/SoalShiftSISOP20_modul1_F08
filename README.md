# SoalShiftSISOP20_modul1_F08
Soal Shift Sistem Operasi 2020
#
1. Sheinna Yendri (18-038)
2. Muhammad Rafi Yudhistira (18-115)
#
1. [Soal1](#soal1)
2. [Soal2](#soal2)
3. [Soal3](#soal3)
#

## Soal1
Soal ini meminta agar kami dapat menampilkan laporan berdasarkan data yang ada pada file "Sample-Superstore.tsv". Laporan yang diminta adalah sebagai berikut:

1. (a) Tentukan wilayah bagian (region) mana yang memiliki keuntungan (profit) paling sedikit.
2. (b) Tampilkan 2 negara bagian (state) yang memiliki keuntungan (profit) paling sedikit berdasarkan hasil poin a.
3. (c) Tampilkan 10 produk (product name) yang memiliki keuntungan (profit) paling sedikit berdasarkan 2 negara bagian (state) hasil poin b.

Hint: Gunakan Awk dan Command pendukung.
#

### Jawab 1a
Pertama-tama, karena file Sample-Superstore.tsv bertipe file tsv (Tab-Separated Values), maka digunakan command ```FS = "\t"``` agar awk dapat memilah text setiap menemukan tanda baca koma (,).

Karena field wilayah bagian (region) berada pada kolom ke-13, maka dapat diakses dengan syntax ```$13``` (sebagai argumen ke-13), sedangkan field profit berada pada kolom ke-21, maka dapat diakses dengan syntax ```$21``` (sebagai argumen ke-21). Kemudian untuk mengelompokkan total profit yang didapatkan masing-masing region, dapat menggunakan array yang bersifat seperti map (dalam C), di mana index-nya merupakan nama region, dan value/isinya merupakan profit total masing-masing region.

Akan tetapi, dikarenakan field header ("Region") dapat terlacak sebagai salah satu region, maka diberi tambahan kondisi region hanya dihitung jika bukan merupakan "Region". Sedangkan untuk mencari profit paling rendah, kami menggunakan perintah dasar BASH ```pipe (|)``` untuk menjadikan output (list profit tiap region) sebagai input untuk di-sort, serta output dari sort ini nantinya juga akan menjadi input untuk perintah ```head -1``` untuk mengambil 1 list teratas, yang berarti mendapatkan region dengan total profit minimal.

Syntax AWK soal 1a adalah sebagai berikut:
```awk
awk 'BEGIN { FS = "\t" }
{ if( $13 != "Region" ) { a[$13] += $21 } }
END { for(b in a) { print a[b], b } }' Sample-Superstore.tsv | sort -g | head -1
```

Output:

![soal1a](https://user-images.githubusercontent.com/48936125/74815049-0fae4600-532b-11ea-8969-88b01321625e.png)
#

### Jawab 1b
Karena field negara bagian (state) berada pada kolom ke-11, maka dapat diakses dengan syntax ```$11``` (sebagai argumen ke-11), sedangkan field profit sama seperti soal 1a, berada pada kolom ke-21, maka dapat diakses dengan syntax ```$21``` (sebagai argumen ke-21). Kemudian untuk mengelompokkan total profit yang didapatkan masing-masing state, sama seperti soal 1a. Perbedaannya adalah state yang dicek/ditotal hanyalah state yang memiliki region "Central" (sesuai output 1a).
Sedangkan untuk menampilkan 2 state dengan profit terendah, selain menggunakan pipe untuk sorting, digunakan lagi untuk membatasi hanya 2 list teratas yang diambil dengan command ```head-2```.

Syntax AWK soal 1b adalah sebagai berikut:
```awk
awk 'BEGIN { FS = "\t" } 
{ if( $13 == "Central" ) { a[$11] += $21 } } 
END { for(b in a) { print a[b], b } }' Sample-Superstore.tsv  | sort -g | head -2
```

Output:

![soal1b](https://user-images.githubusercontent.com/48936125/74815329-a11db800-532b-11ea-83ed-4cc3b3398810.png)
#

### Jawab 1c
Sama seperti soal 1a dan 1b, menggunakan argumen dan array untuk menjumlah total profit masing-masing produk. Produk berada pada kolom ke-17, sehingga dapat diakses dengan syntax ```$17``` (sebagai argumen ke-17). Dan untuk mengambil 10 list produk dengan total profit terendah, menggunakan syntax ```head -10```.

Syntax AWK soal 1c adalah sebagai berikut:
```awk
awk 'BEGIN { FS = "\t" }
{ if( $11 == "Texas" || $11 == "Illinois" ) { a[$17] += $21 } }
END { for(b in a) { print a[b], b } }' Sample-Superstore.tsv | sort -g | head -10
```
Output:

![soal1c](https://user-images.githubusercontent.com/48936125/74815385-b692e200-532b-11ea-82e5-8b5bceab8468.png)
#

## Soal2
1. (a) Soal ini meminta kami untuk mengenerate password random yang memiliki kriteria sebagai berikut:
* Terdiri dari 28 karakter.
* Hanya mengandung karakter huruf besar, huruf kecil, serta angka.

2. (b) Kemudian password random ini akan disimpan pada file berekstensi ```.txt``` dengan nama berdasarkan argumen yang diinputkan dan *HANYA berupa alfabet*.

3. (c) Lalu nama yang diinputkan dalam argumen itu akan di-enkripsi caesar cipher dengan selisih angka sesuai jam di-generate-nya password tersebut.

4. (d) Kami juga harus membuat program agar dapat mendekripsi kembali nama file .txt tersebut.
#

### Jawab 2a
Pertama-tama, kami menggunakan bantuan library ```tr``` dari BASH untuk mengerate password random sesuai kriteria, dengan syntax sebagai berikut:
```bash
(< /dev/urandom tr -dc A-Za-z0-9 | head -c28;) > $namabaru.txt
```
Syntax ```A-Za-z0-9``` membatasi agar password random yang digenerate hanya mengandung huruf besar, huruf kecil, serta angka. Sedangkan syntax ```head -c28``` membatasi agar password random yang digenerate terdiri dari 28 karakter. Kemudian lambang ```>``` berarti hasil password yang digenerate akan disimpan dalam suatu file bertipe ```.txt``` bernama ```$namabaru```.
#

### Jawab 2b
Nama file yang diinputkan dalam bentuk argumen akan ditampung dalam suatu variabel dalam BASH: (digunakan untuk membuang bagian .txt yang diinputkan user).
```bash
nama="$(cut -d'.' -f1 <<<"$1")"
```
Command ini berarti akan memilah argumen pertama ```$1``` setiap menemukan tanda baca titik ```cut -d'.'```, kemudian akan mengambil segment yang pertama ```-f1```. Sehingga sekarang variable nama akan berisikan nama file yang diinginkan user (tanpa ```.txt```).

Contoh: ```bash soal2.sh password.txt```
Maka variable nama akan berisi "password".
#

### Jawab 2c
Pada soal ini akan dilakukan enkripsi terhadap nama yang sudah didapatkan dari argumen yang diinputkan berdasarkan jam di-generate-nya password tersebut. Oleh karena itu, kami harus mengambil jam sekarang dengan perintah:
```bash
hour=`date +"%H"`
```
Kemudian kami membuat array bernama ```CONV``` berisi tr command untuk melakukan caesar cipher:
```bash
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
```
Kemudian untuk meng-enkripsi nama yang telah disimpan dalam variable ```$nama``` akan dikonversi dengan bantuan library ```tr``` dan pipe ```|```, sebagai berikut:
```bash
namabaru=$(echo $nama | ${CONV[$hour]})
```
Sekarang variable namabaru akan berisi nama yang sudah dienkripsi sesuai dengan jam di-generate-nya password tersebut.
Perintah ```tr 'a-zA-Z' 'z-za-yZ-ZA-Y'``` memiliki makna untuk mengubah setiap karakter a menjadi z, b menjadi a, dan seterusnya, begitu juga dengan A menjadi Z, ..., hingga Z menjadi Y.

Output enkripsi nama file dan isi file password random:
![soal2a](https://user-images.githubusercontent.com/48936125/74936333-85dea580-541c-11ea-8b25-b5a2b6bae15f.png)
![soal2jam](https://user-images.githubusercontent.com/48936125/74936340-88d99600-541c-11ea-82ac-f3c675ebfc94.png)

#

### Jawab 2d
Untuk mendekripsi, kami membuat file program bash terpisah bernama ```soal2_decrypt.sh``` dengan parameter nama file yang akan didekripsi dengan format ```[nama_yang_ingin_didekrpsi].txt```. Untuk men-separasi argumen yang diinputkan:
```bash
nama="$(cut -d'.' -f1 <<<"$1")"
hour=`date -r $nama.txt "+%H"`
```
Fungsi ```cut``` sama seperti yang telah dijabarkan di soal 2c. Sehingga variable nama akan berisi nama yang ingin didekripsi, sedangkan variable hour akan berisi jam terakhir file dengan nama ```$nama``` dimodifikasi (dapat dinyatakan dengan dibuat, karena file ini tidak diedit) menggunakan syntax ```date -r [namafile].txt "+%H"```. Jam file tersebut terakhir dimodifikasi diperlukan agar dapat mendekripsi kembali sesuai dengan jam dibuatnya, agar perhitungan selisih enkripsi caesar cipher tidak kacau/bergeser.

Untuk dekripsi kami juga menggunakan library ```tr``` yang disimpan dalam array CONV sebagai berikut:
```bash
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
```
Kemudian untuk mendekripsi, sama seperti pada saat melakukan enkripsi, kami menggunakan pipe ```|``` dan menggunakan fungsi ```tr``` agar nama sebenarnya dapat ditampung dalam variabel ```namaawal```, sehingga dapat ditampilkan:
```bash
namaawal=$(echo $nama | ${CONV[$hour]})
echo "Original file name: "$namaawal".txt"
```

Output original file name dari hasil didekripsi:
![soal2b](https://user-images.githubusercontent.com/48936125/74936409-a870be80-541c-11ea-8ff4-b3946050f26c.png)

#

## Soal3
1. Soal ini meminta kami untuk:
a. Membuat script untuk mendownload 28 *file* gambar dari "https://loremflickr.com/320/240/cat" menggunakan wget dan menyimpan hasilnya dengan format nama "pdkt_kusuma_NO" serta menyimpan **log message wget** di file "wget.log"
b. Membuat penjadwalan untuk mendownload seperti yang di jelaskan soal a, dengan persyaratan :
	* file di download setiap 8 jam
	* setiap hari dimulai dari jam 6.05
	* tidak berjalan pada hari sabtu
c. Setelah men-download gambar, kita ditugaskan untuk mem-buat script untuk men-sortir gambar tersebut. nantinya akan dibuat folder "./kenangan" "./duplicate". gambar akan bernama "kenangan_NO". Namun jika ter indikasi gambar yang identik, akan membuang 1 gambar ke "./duplikat" dan ber-format nama "duplicate_NO". saat gambar habis untuk di sortir, kita membuat backup seluruh log menjadi ekstensi ".log.bak".

#

### Soal3a
Pertama-tama, kita membuat file dengan nama "no3.sh". bash script ini akan berfungsi selain mendowonload, juga untuk men sortir gambar-gambar apakah dia akan masuk ./duplicate atau ./kenangan. berikut adalah script "no3.sh" bagian untuk mendownload 28 file gambar:
```bash
#! /bin/bash

mkdir /home/rapuyy/Downloads/tugas/prak1/no3/kenangan
mkdir /home/rapuyy/Downloads/tugas/prak1/no3/duplicate

 > /home/rapuyy/Downloads/tugas/prak1/no3/wget.log   
 > /home/rapuyy/Downloads/tugas/prak1/no3/location.log 

for ((a=1; a<=28; a=a+1))
	do
	wget -a /home/rapuyy/Downloads/tugas/prak1/no3/wget.log "https://loremflickr.com/320/240/cat" -O /home/rapuyy/Downloads/tugas/prak1/no3/pdkt_kusuma_"$a".jpeg 
#	cat rapuyy.txt >> wget.log
done

grep "Location" /home/rapuyy/Downloads/tugas/prak1/no3/wget.log > /home/rapuyy/Downloads/tugas/prak1/no3/location.log

```
disitu kami melakukan perulangan sebanyak 28 kali menggunakan for. selagi mendownload, kita sekaligus mengubah wget menjadi`wget -a /home/rapuyy/Downloads/tugas/prak1/no3/wget.log "https://loremflickr.com/320/240/cat" -O /home/rapuyy/Downloads/tugas/prak1/no3/pdkt_kusuma_"$a".jpeg` agar saat file terdownload, namanya berubah menjadi format sesuai soal.

#

### Soal3b
untuk bagian 3b, kita akan membuat crontab agar pendownload-an bisa dilakukan secara otomatis dengan syarat sesuai soal. berikut adalah crontab nya :
> 5 6-23/8 * * 0-5 bash /home/rapuyy/Downloads/tugas/prak1/no3/no3.sh

#

### soal3c
setelah file di download, kita membuat script untuk men-sortir gambar untuk menentukan apakah dia masuk ./duplikat atau masuk ./kenangan. codingannya:
```bash
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
```

#
