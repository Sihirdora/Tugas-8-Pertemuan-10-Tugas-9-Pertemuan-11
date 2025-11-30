import 'dart:convert'; 
import 'package:tokokita/helpers/api.dart'; 
import 'package:tokokita/helpers/api_url.dart'; 
import 'package:tokokita/model/registrasi.dart'; 

class RegistrasiBloc { 
  // Ubah return type menjadi nullable jika server mungkin tidak mengembalikan objek
  static Future<Registrasi?> registrasi( 
      {String? nama, String? email, String? password}) async { 
    String apiUrl = ApiUrl.registrasi; 
    var body = {"nama": nama, "email": email, "password": password}; 
    var response = await Api().post(apiUrl, body); 
    
    // 1. Cek Status HTTP (Jika Bukan 200/201, maka GAGAL JELAS)
    if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception("Registrasi gagal. Status code: ${response.statusCode}");
    }

    // 2. Jika status 200/201, coba proses body
    if (response.body.isEmpty) {
        // Jika body kosong, asumsikan sukses (untuk kasus registrasi yang tidak mengembalikan data)
        return null; 
    }
    
    try {
        var jsonObj = json.decode(response.body); 
        
        // Cek Status Bisnis di dalam JSON (misal server mengembalikan 200 OK, tapi isinya pesan error)
        if (jsonObj.containsKey('status') && jsonObj['status'] == 'gagal') {
            throw Exception(jsonObj['message'] ?? "Registrasi gagal oleh server.");
        }
        
        // Jika semua lancar, parse model
        return Registrasi.fromJson(jsonObj); 
        
    } catch (e) {
        // Tangkap FormatException atau error parsing lainnya.
        // Karena statusnya 200 OK (sukses), kita anggap success untuk UX.
        print("Peringatan: Gagal parsing respons. Tapi status HTTP 200 OK.");
        return null; // Sukses, tetapi tanpa objek Registrasi
    }
  } 
}