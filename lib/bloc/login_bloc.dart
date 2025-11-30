import 'dart:convert';
import 'package:tokokita/helpers/api.dart';
import 'package:tokokita/helpers/api_url.dart';
import 'package:tokokita/model/login.dart';

class LoginBloc {
  static Future<Login> login({String? email, String? password}) async {
    String apiUrl = ApiUrl.login;
    var body = {"email": email, "password": password};

    // 1. Lakukan permintaan POST
    var response = await Api().post(apiUrl, body);

    // 2. Decode respons JSON
    var jsonObj = json.decode(response.body);

    // 3. Tambahkan penanganan error HTTP (misalnya status non-200)
    if (response.statusCode != 200) {
      // Jika server mengembalikan status HTTP non-200, lempar error.
      // Anda dapat menyesuaikan pesan error dari jsonObj jika tersedia.
      throw Exception(jsonObj['message'] ?? 'Login gagal, terjadi kesalahan server.');
    }
    
    // 4. Parsing ke Model Login
    // Lanjutkan ke langkah berikutnya di perbaikan model jika respons status 200.
    return Login.fromJson(jsonObj);
  }
}