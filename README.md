# myportofolio_mobile

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

### Tugas 7
1. widget tree adalah struktur hierarki yang menyusun seluruh tampilan aplikasi karena di flutter itu ada istilah bahwa "semuanya adalah widget"
parent child adalah widget induk (parent) yang membungkus widget anak (child) di dalamnya untuk mengatur tata letak dan aliran data

2. scaffold: menyediakan kerangka visual dasar halaman (seperti struktur tata letak standar, area AppBar, dan manajemen SnackBar)
appbar: menampilkan bagian judul di bagian atas layar aplikasi
padding: memberikan spacing di sekeliling widget anaknya
column: menyusun widget anak-anaknya secara vertikal (dari atas ke bawah)
row: menyusun widget anak-anaknya secara horizontal (dari kiri ke kanan, digunakan untuk 3 kartu InfoCard)
text: menampilkan teks di layar
center: mengatur posisi widget anaknya agar berada di tengah
gridview.count: menampilkan widget anak (tombol menu) dalam bentuk grid dengan jumlah kolom tertentu
card: memberikan efek elevation pada kartu agar tampilan lebih bagus
container: tempat untuk mengatur ukuran (width), padding, atau dekorasi
material: menyediakan material design dasar (seperti warna latar belakang unik item.color dan sudut borderRadius)
inkwell: menambahkan efek animasi sentuh (ripple effect) dan fungsi interaksi saat widget ditekan (onTap)
icon: menampilkan ikon visual (seperti folder, tambah, atau logout)

3. materialapp berfungsi sebagai konfigurasi dasar yang mengatur standar desain google (material design), tema warna global, dan sistem navigasi aplikasi, sehingga wajib ada di lapisan paling atas (root)

4. statelesswidget bersifat statis dan tampilannya tidak bisa berubah setelah dirender (cocok untuk profil atau menu tetap)
statefulwidget bersifat dinamis dan dapat berubah sewaktu-waktu berdasarkan interaksi atau data (cocok untuk form)

5. buildcontext merepresentasikan posisi widget di dalam widget tree. peran utamanya adalah melacak lokasi widget (misalnya untuk memanggil  ScaffoldMessenger saat menampilkan SnackBar)

6. hot reload berfungsi untuk memasukkan kode baru tanpa mereset status/state aplikasi
hot restart berfungsi untuk mereset ulang seluruh aplikasi dan menghapus state dari awal. wajib dilakukan jika ada perubahan struktur yang besar (seperti fungsi main())

dalam pengerjaan tugas 7 ini, saya menggunakan bantuan ai yaitu gemini sebagai teman diskusi untuk memahami konsep dasar flutter dan merapikan struktur kode di menu.dart. walau terbantu dalam menyusun struktur kode, seluruh proses penyesuaian identitas pribadi, pengujian aplikasi, sampai pengecekan error melalui flutter analyze tetap saya verifikasi sendiri secara manual

### Tugas 8
1. navigator.push() menumpuk halaman baru di atas halaman lama agar bisa kembali, navigator.pushreplacement() mengganti halaman aktif saat ini, dan navigator.pop() menutup halaman teratas. kartu aksi memakai navigator.push() untuk membuka form, sedangkan opsi home di drawer memakai navigator.pushreplacement() ke halaman utama

2. susunan scaffold, appbar, dan drawer menjaga kerangka layar, header atas, serta menu navigasi samping tetap seragam di setiap halaman. misalnya, warna tema utama aplikasi digunakan secara konsisten pada AppBar di halaman utama maupun halaman form.

3. tata letak vertikal memudahkan alur isian form, widget yang mengatur jarak (seperti sizedbox dan padding) memberi ruang antar elemen, dan singlechildscrollview membuat form bisa discroll agar tidak overflow dan tombol simpan tetap terjangkau saat layar sempit atau papan ketik muncul

4. globalkey mengakses state form, validator mengecek aturan tiap kolom, dan validate() menjalankan semua pengecekan saat tombol simpan ditekan. contoh input yang ditolak adalah tanggal selesai lebih awal dari tanggal mulai (atau kolom wajib kosong/spasi), karena jenis input atau papan ketik saja tidak mencegah input tidak valid secara aturan maupun logika

pada pengerjaan tugas 8, saya memanfaatkan gemini untuk berdiskusi dalam merancang alur navigasi, struktur form, dan logika validasi. walau terbantu dengan ai, seluruh penyesuaian program di akhir, serta uji tampilan di desktop dan ponsel, tetap saya review dan pastikan sendiri secara manual