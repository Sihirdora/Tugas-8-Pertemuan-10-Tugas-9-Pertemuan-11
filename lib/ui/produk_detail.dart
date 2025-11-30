import 'package:flutter/material.dart';
import 'package:tokokita/bloc/produk_bloc.dart';
import 'package:tokokita/model/produk.dart';
import 'package:tokokita/ui/produk_form.dart';
import 'package:tokokita/ui/produk_page.dart';
import 'package:tokokita/widget/warning_dialog.dart';

// ignore: must_be_immutable
class ProdukDetail extends StatefulWidget {
  Produk? produk;

  ProdukDetail({Key? key, this.produk}) : super(key: key);

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
            Text(
              "Kode : ${widget.produk!.kodeProduk}",
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              "Nama : ${widget.produk!.namaProduk}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "Harga : Rp. ${widget.produk!.hargaProduk.toString()}",
              style: const TextStyle(fontSize: 18.0),
            ),
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
        const SizedBox(width: 10), // Memberi sedikit jarak
        // Tombol Hapus
        OutlinedButton(
          child: const Text("DELETE"),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      title: const Text("Konfirmasi Hapus"),
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
        // Tombol Ya (Hapus)
        OutlinedButton(
          child: const Text("Ya"),
          onPressed: () {
            // Tutup dialog konfirmasi terlebih dahulu
            Navigator.pop(context); 

            // --- Logika Penghapusan yang Diperbaiki ---
            String? idString = widget.produk?.id;
            int? idProduk;
            
            // 1. Validasi dan Parsing ID
            if (idString == null || idString.isEmpty) {
                _showErrorDialog("ID produk tidak ditemukan atau kosong.");
                return;
            }
            
            try {
                // Mencoba parsing ID
                idProduk = int.parse(idString);
            } catch (e) {
                // Jika parsing gagal (misal: ID bukan angka)
                _showErrorDialog("ID produk tidak valid. Kesalahan: $e");
                return;
            }
            
            // 2. Eksekusi Delete
            ProdukBloc.deleteProduk(id: idProduk).then(
              (value) {
                // Sukses: Ganti halaman ke ProdukPage
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const ProdukPage())
                );
              },
              onError: (error) {
                // Gagal: Tangkap error dari ProdukBloc
                print("Error saat menghapus produk: $error");
                _showErrorDialog("Hapus gagal, silahkan coba lagi. Detail: $error");
              },
            );
          },
        ),
        // Tombol Batal
        OutlinedButton(
          child: const Text("Batal"),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );

    showDialog(builder: (context) => alertDialog, context: context);
  }
  
  // Fungsi Helper untuk menampilkan WarningDialog
  void _showErrorDialog(String message) {
     showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => WarningDialog(
            description: message,
        ),
    );
  }
}