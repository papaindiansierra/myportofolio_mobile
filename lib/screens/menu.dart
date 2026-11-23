import 'package:flutter/material.dart';
// mengimpor widget LeftDrawer untuk menu navigasi samping
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
// mengimpor widget ProjectCard (ItemHomepage & ItemCard)
import 'package:myportofolio_mobile/widgets/project_card.dart';

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
    ItemHomepage("Tambah Pengalaman", Icons.work_history, Colors.orange),
    ItemHomepage("Logout", Icons.logout, Colors.red),
  ];

  @override
  Widget build(BuildContext context) {
    // scaffold untuk menyediakan struktur visual dasar halaman. yaitu AppBar, Body, SnackBar, dan Drawer
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
        // mengubah warna ikon (termasuk ikon hamburger untuk membuka drawer) menjadi putih
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      // memasang LeftDrawer sebagai menu navigasi geser dari sisi kiri layar
      drawer: const LeftDrawer(),
      // body halaman utama dibuat scrollable agar tidak overflow saat kartu turun ke baris kedua atau di layar sempit
      body: SafeArea(
        child: SingleChildScrollView(
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
                      primary: false,
                      padding: const EdgeInsets.all(20),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 3,
                      childAspectRatio: 1.0,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
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