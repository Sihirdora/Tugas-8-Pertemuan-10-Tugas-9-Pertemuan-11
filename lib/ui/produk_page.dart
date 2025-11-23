import 'package:flutter/material.dart';
import 'package:tokokita/model/produk.dart';
import 'package:tokokita/ui/produk_detail.dart';
import 'package:tokokita/ui/produk_form.dart';

class ProdukPage extends StatefulWidget {
  // Menggunakan super.key untuk sintaks yang lebih ringkas (Saran Lint)
  const ProdukPage({super.key}); 

  @override
  _ProdukPageState createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Produk Fei'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: const Icon(Icons.add, size: 26.0),
              onTap: () async {
                // Perbaikan Error 1: Hapus 'const' karena ProdukForm mungkin bukan const
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProdukForm()),
                );
              },
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Logout'),
              trailing: const Icon(Icons.logout),
              onTap: () async {
                // Logika logout akan diletakkan di sini
                Navigator.pop(context); 
              },
            )
          ],
        ),
      ),
      body: ListView(
        children: [
          // Contoh data dummy produk
          // Perbaikan Error 2: Tipe data 'int' sekarang cocok dengan model Produk
          ItemProduk(
            produk: Produk(
              id: "1",
              kodeProduk: 'A001',
              namaProduk: 'Kamera Fei',
              hargaProduk: 5000000,
            ),
          ),
          ItemProduk(
            produk: Produk(
              id: "2",
              kodeProduk: 'A002',
              namaProduk: 'Kulkas Fei',
              hargaProduk: 2500000,
            ),
          ),
          ItemProduk(
            produk: Produk(
              id: "3",
              kodeProduk: 'A003',
              namaProduk: 'Mesin Cuci Fei',
              hargaProduk: 2000000,
            ),
          ),
        ],
      ),
    );
  }
}

// ---

class ItemProduk extends StatelessWidget {
  final Produk produk;
  
  // Menggunakan super.key untuk sintaks yang lebih ringkas (Saran Lint)
  const ItemProduk({super.key, required this.produk});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman detail produk
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProdukDetail(
              produk: produk,
            ),
          ),
        );
      },
      child: Card(
        // Padding/Margin untuk Card agar terlihat lebih baik
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0), 
        child: ListTile(
          title: Text(produk.namaProduk!),
          // hargaProduk adalah int, jadi harus diubah menjadi String untuk widget Text
          subtitle: Text(produk.hargaProduk.toString()),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16.0),
        ),
      ),
    );
  }
}