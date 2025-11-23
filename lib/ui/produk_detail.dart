import 'package:flutter/material.dart';

import 'package:tokokita/model/produk.dart';
import 'package:tokokita/ui/produk_form.dart';
import 'package:tokokita/ui/produk_page.dart';


// ignore: must_be_immutable
class ProdukDetail extends StatefulWidget {
  final Produk? produk; // Gunakan final untuk properti StatelessWidget/StatefulWidget

  // Menggunakan super parameter untuk memperbaiki hint Dart
  const ProdukDetail({super.key, this.produk});

  @override
  _ProdukDetailState createState() => _ProdukDetailState();
}

class _ProdukDetailState extends State<ProdukDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
      ),
      body: Center(
        child: Column(
          children: [
            // Tambahkan sedikit spasi di atas
            const SizedBox(height: 20.0),
            Text(
              "Kode : ${widget.produk!.kodeProduk}",
              style: const TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 10.0),
            Text(
              "Nama : ${widget.produk!.namaProduk}",
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 10.0),
            Text(
              "Harga : Rp. ${widget.produk!.hargaProduk.toString()}",
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 20.0),
            _tombolHapusEdit()
          ],
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Tombol Edit
        OutlinedButton(
          child: const Text("EDIT"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProdukForm(
                  produk: widget.produk!,
                ),
              ),
            );
          },
        ),
        // Tambahkan spasi antar tombol
        const SizedBox(width: 10),
        // Tombol Hapus
        OutlinedButton(
          child: const Text("DELETE"),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

void confirmHapus() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: const Text("Yakin ingin menghapus data ini?"),
        actions: [
          // Tombol Ya (Sekarang hanya melakukan navigasi)
          OutlinedButton(
            child: const Text("Ya"),
            onPressed: () {
              // --- LOGIKA PRODUKBLOC DIHAPUS ---

              // Solusi sementara: Langsung navigasi ke ProdukPage
              // Ini mensimulasikan penghapusan yang berhasil.
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const ProdukPage()),
                (Route<dynamic> route) => false,
              );
              // --- END LOGIKA PRODUKBLOC DIHAPUS ---
            },
          ),
          // Tombol Batal
          OutlinedButton(
            child: const Text("Batal"),
            onPressed: () => Navigator.pop(context),
          )
        ],
      );
    },
  );
}
}