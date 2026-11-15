import 'package:flutter/material.dart';

// menambah atribut 'color' pada kelas model biar pewarnaan tombol jadi modular dan ringkas (biar ga buat banyak cabang if else)
class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color; // atribut warna latar belakang kartu

  ItemHomepage(this.name, this.icon, this.color);
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  // ubah data sesuai identitas diri sendiri
  final String npm = "2506621812";
  final String nama = "Muhammad Hafidz Muazzam";
  final String kelas = "PBP C";

  // daftar item menu dengan warna, tiap tombol warnanya beda
  final List<ItemHomepage> items = [
    ItemHomepage("Lihat Proyek", Icons.folder, Colors.blue),
    ItemHomepage("Tambah Proyek", Icons.add_circle, Colors.green),
    ItemHomepage("Logout", Icons.logout, Colors.red),
  ];

  @override
  Widget build(BuildContext context) {
    // scaffold untuk menyediakan struktur visual dasar halaman. yaitu AppBar, Body, SnackBar
    return Scaffold(
      // AppBar untuk menampilkan bar bagian atas halaman aplikasi
      appBar: AppBar(
        title: const Text(
          'MyPortfolio',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      // body halaman utama dan padding di kelilingnya
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // baris horizontal untuk menampilkan 3 InfoCard dengan sejajar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InfoCard(title: 'NPM', content: npm),
                InfoCard(title: 'Name', content: nama),
                InfoCard(title: 'Class', content: kelas),
              ],
            ),

            const SizedBox(height: 16.0),

            // bagian tengah, text 'selamat datang' dan tombol menu portofolio
            Center(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Text(
                      'Selamat datang di MyPortfolio Mobile!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),

                  // GridView untuk menampilkan kartu tombol dalam tata letak kisi 3 kolom
                  GridView.count(
                    primary: true,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    children: items.map((ItemHomepage item) {
                      return ItemCard(item);
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  // kartu informasi yang menampilkan judul (title) dan isi (content)
  final String title;
  final String content;

  const InfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      // effect shadow kartu elevasi
      elevation: 2.0,
      child: Container(
        // menyesuaikan lebar kartu dengan proporsi layar (dibagi dengan 3.5)
        width: MediaQuery.of(context).size.width / 3.5,
        padding: const EdgeInsets.all(16.0),
        // menyusun teks title dan content secara vertikal
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(content, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      // menerapkan warna latar unik
      // mengambil warna langsung dari atribut item.color yang sudah didefinisikan di list
      color: item.color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        // aksi ketika kartu ditekan oleh pengguna
        onTap: () {
          // menampilkan SnackBar dengan pesan interaktif sesuai nama tombol saat ditap
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text("Kamu telah menekan tombol ${item.name}!"))
            );
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}