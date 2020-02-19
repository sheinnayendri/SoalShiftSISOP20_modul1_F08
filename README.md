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
Soal ini meminta agar kami dapat menampilkan laporan berdasarkan data yang ada pada file "Sample-Superstore.csv". Laporan yang diminta adalah sebagai berikut:

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

![soal1b](https://user-images.githubusercontent.com/48936125/74815126-3cfaf400-532b-11ea-9b8c-a3d0274f27fb.png)
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

![soal1c](https://user-images.githubusercontent.com/48936125/74815091-248ad980-532b-11ea-9361-2a51cfe77e2a.png)
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
(< /dev/urandom tr -dc A-Za-z0-9 | head -c28;) > $namafix.txt
```
Syntax ```A-Za-z0-9``` membatasi agar password random yang digenerate hanya mengandung huruf besar, huruf kecil, serta angka. Sedangkan syntax ```head -c28``` membatasi agar password random yang digenerate terdiri dari 28 karakter. Kemudian lambang ```>``` berarti hasil password yang digenerate akan disimpan dalam suatu file bertipe ```.txt``` bernama ```$namafix```.
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
namafix=$namabaru\_$hour
```
Sekarang variable namabaru akan berisi nama yang sudah dienkripsi sesuai dengan jam di-generate-nya password tersebut.
Perintah ```tr 'a-zA-Z' 'z-za-yZ-ZA-Y'``` memiliki makna untuk mengubah setiap karakter a menjadi z, b menjadi a, dan seterusnya, begitu juga dengan A menjadi Z, ..., hingga Z menjadi Y.

Dikarenakan kami mungkin memerlukan nama asli text tersebut kembali (sebelum dienkripsi), maka dibutuhkan program untuk dekripsi nama file tersebut, akan tetapi tentu saja kami harus tahu pada pukul berapa password random tadi di-generate, agar dapat men-dekripsi pada format yang sesuai. Oleh karena itu, kami memodifikasi nama file dengan menambahkan ```_[jam_generate_password]``` agar saat ingin melakukan dekripsi nama file, kami tahu selisih caesar ciphernya berapa. Karena semisal nama file password.txt digenerate pada pukul 13.54, maka akan berubah menjadi ```cnffjbeq.txt``` (selisih = 13), tetapi saat ingin mendekripsi nama file, jam berubah menjadi pukul 14.02, maka file ```cnffjbeq.txt``` akan didekripsi menjadi ```ozrrvnqc.txt``` bukan nama sebenarnya yaitu ```password.txt```. Jadi nama file yang baru akan kami simpan menjadi ```cnffjbeq_13.txt``` menandakan di-generate pada pukul 13.

Output enkripsi nama file dan isi file password random:
![soal2a](https://user-images.githubusercontent.com/48936125/74812504-39b13980-5326-11ea-90eb-35baf29b3e21.png)
![soal2aa](https://user-images.githubusercontent.com/48936125/74812516-3ddd5700-5326-11ea-804c-fcea9f93aa45.png)
![soal2jam](https://user-images.githubusercontent.com/48936125/74812594-59486200-5326-11ea-90db-43b32e2ea228.png)

#

### Jawab 2d
Untuk mendekripsi, kami membuat file program bash terpisah bernama ```soal2_decrypt.sh``` dengan parameter nama file yang akan didekripsi dengan format ```[nama_yang_ingin_didekrpsi]_[jam_digenerate].txt```. Untuk men-separasi argumen yang diinputkan:
```bash
awal="$(cut -d'.' -f1 <<<"$1")"
nama="$(cut -d'_' -f1 <<<"$awal")"
hour=`date +"%H"`
awal="$(cut -d'.' -f1 <<<"$1")"
hour="$(cut -d'_' -f2 <<<"$awal")"
```
Fungsi ```cut``` sama seperti yang telah dijabarkan di soal 2c. Sehingga variable nama akan berisi nama yang ingin didekripsi, sedangkan hour akan berisi jam di-generatenya password tadi.

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
![soal2b](https://user-images.githubusercontent.com/48936125/74812554-4c2b7300-5326-11ea-9256-ea2ad9de2018.png)

#
