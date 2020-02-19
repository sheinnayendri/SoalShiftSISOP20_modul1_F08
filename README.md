# SoalShiftSISOP20_modul1_F08
Soal Shift Sistem Operasi 2020
#
1. Sheinna Yendri (18-038)
2. Muhammad Rafi Yudhistira (18-115)
#
1. [Soal 1](#soal1)
2. [Soal 2](#soal2)
3. [Soal 3](#soal3)
#

## Soal 1
Soal ini meminta agar kami dapat menampilkan laporan berdasarkan data yang ada pada file "Sample-Superstore.csv". Laporan yang diminta adalah sebagai berikut:

a. Tentukan wilayah bagian (region) mana yang memiliki keuntungan (profit) paling sedikit.
b. Tampilkan 2 negara bagian (state) yang memiliki keuntungan (profit) paling sedikit berdasarkan hasil poin a.
c. Tampilkan 10 produk (product name) yang memiliki keuntungan (profit) paling sedikit berdasarkan 2 negara bagian (state) hasil poin b.

Hint: Gunakan Awk dan Command pendukung.
#

### Jawab 1a
Karena field wilayah bagian (region) berada pada kolom ke-11, maka dapat diakses dengan syntax $11 (sebagai argumen ke-11), sedangkan field profit berada pada kolom ke-21, maka dapat diakses dengan syntax $21 (sebagai argumen ke-21). Kemudian untuk mengelompokkan total profit yang didapatkan masing-masing region, dapat menggunakan array yang bersifat seperti map (dalam C), di mana index-nya merupakan nama region, dan value/isinya merupakan profit total masing-masing region.

Kemudian, dikarenakan field header ("Region") dapat terlacak sebagai salah satu region, maka diberi tambahan kondisi region hanya dihitung jika bukan merupakan "Region". Sedangkan untuk mencari profit paling rendah, kami menggunakan perintah dasar BASH (pipe (|)) untuk menjadikan output (list profit tiap region) sebagai input untuk di-sort, serta output dari sort ini nantinya juga akan menjadi input untuk perintah head -1 untuk mengambil 1 list teratas, yang berarti mendapatkan region dengan total profit minimal.

Syntax AWK soal 1a adalah sebagai berikut:
```awk
awk 'BEGIN { FS="," }
{ if ( $11 != "Region" ) { a[$11] += $21 } }
END { for b in a { print a[b], b } }' Sample-Superstore.csv | sort -g | head -1
```

