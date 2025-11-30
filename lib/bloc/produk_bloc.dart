import 'dart:convert';
import 'package:tokokita/helpers/api.dart';
import 'package:tokokita/helpers/api_url.dart';
import 'package:tokokita/model/produk.dart';
import 'package:http/http.dart' as http; // Import ini diperlukan untuk menggunakan tipe Response

class ProdukBloc {
  static Future<List<Produk>> getProduks() async {
    String apiUrl = ApiUrl.listProduk;
    var response = await Api().get(apiUrl);
    
    // Penanganan error dasar
    if (response.statusCode != 200) {
      throw Exception('Gagal memuat produk. Status: ${response.statusCode}');
    }

    // Lanjutkan parsing jika status 200
    var jsonObj = json.decode(response.body);
    // Asumsi: data list produk berada di kunci 'data'
    List<dynamic> listProduk = (jsonObj as Map<String, dynamic>)['data'];
    List<Produk> produks = [];
    for (int i = 0; i < listProduk.length; i++) {
      produks.add(Produk.fromJson(listProduk[i]));
    }
    return produks;
  }

  static Future addProduk({Produk? produk}) async {
    String apiUrl = ApiUrl.createProduk;

    var body = {
      "kode_produk": produk!.kodeProduk,
      "nama_produk": produk.namaProduk,
      "harga": produk.hargaProduk.toString()
    };

    var response = await Api().post(apiUrl, body);
    
    // Penanganan error/respons dari server
    if (response.statusCode != 200) {
      // Coba decode body error jika ada
      String errorMessage = response.body.isNotEmpty 
          ? json.decode(response.body)['message'] ?? 'Gagal menambah produk'
          : 'Gagal menambah produk. Status: ${response.statusCode}';
      throw Exception(errorMessage);
    }
    
    var jsonObj = json.decode(response.body);
    // Asumsi: server mengembalikan status di root object
    return jsonObj['status'];
  }

  static Future updateProduk({required Produk produk}) async {
    // Penggunaan operator null-aware '?' dan penanganan parse yang lebih aman
    String idString = produk.id ?? '';
    int? idProduk;
    
    try {
        idProduk = int.parse(idString);
    } catch (e) {
        throw Exception('ID produk tidak valid untuk diupdate: $idString');
    }

    String apiUrl = ApiUrl.updateProduk(idProduk);
    
    var body = {
      "kode_produk": produk.kodeProduk,
      "nama_produk": produk.namaProduk,
      "harga": produk.hargaProduk.toString()
    };
    
    // Catatan: Fungsi Api().put seharusnya menerima Map atau string JSON, 
    // tergantung implementasi Api(). Jika memerlukan JSON string, gunakan jsonEncode(body).
    // Saya asumsikan Api().put dapat menerima Map, tapi kode asli Anda menggunakan jsonEncode, 
    // jadi saya pertahankan, dengan asumsi API().put menerimanya sebagai body string.
    var response = await Api().put(apiUrl, jsonEncode(body));
    
    if (response.statusCode != 200) {
      String errorMessage = response.body.isNotEmpty 
          ? json.decode(response.body)['message'] ?? 'Gagal update produk'
          : 'Gagal update produk. Status: ${response.statusCode}';
      throw Exception(errorMessage);
    }

    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> deleteProduk({int? id}) async {
    // Cek ID adalah not null
    if (id == null) {
      throw Exception('ID produk untuk dihapus tidak boleh null.');
    }
    
    String apiUrl = ApiUrl.deleteProduk(id);
    var response = await Api().delete(apiUrl);

    // 1. Cek Status HTTP
    if (response.statusCode != 200) {
        // Jika status bukan 200, coba ambil pesan error jika ada
        String errorMessage = response.body.isNotEmpty 
            ? json.decode(response.body)['message'] ?? 'Gagal menghapus produk'
            : 'Gagal menghapus produk. Status: ${response.statusCode}';
        throw Exception(errorMessage);
    }

    // 2. TANGANI Respons Kosong (Penyebab 'Unexpected end of JSON input')
    if (response.body.isEmpty) {
      // Jika status 200 OK dan body kosong, anggap sukses.
      return true;
    }

    // 3. Parsing Respons JSON (Hanya jika body tidak kosong)
    try {
      var jsonObj = json.decode(response.body);
      // Asumsi: Server mengembalikan nilai boolean atau 'data' di root
      // Mengubah logika parsing dari kode asli:
      // return (jsonObj as Map<String, dynamic>)['data'];
      
      // Jika server mengembalikan objek status/sukses di root:
      return jsonObj['success'] ?? true; // Ganti 'success' atau 'status' sesuai API Anda
      
    } catch (e) {
        // Jika ada body, tapi parsing gagal (misal JSON tidak valid)
        throw Exception('Gagal mengurai respons server setelah penghapusan: $e');
    }
  }
}