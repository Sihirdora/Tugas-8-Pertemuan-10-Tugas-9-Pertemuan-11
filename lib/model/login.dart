class Login {
  int? code;
  bool? status;
  String? token;
  int? userID;
  String? userEmail;

  Login({this.code, this.status, this.token, this.userID, this.userEmail});

  factory Login.fromJson(Map<String, dynamic> obj) {
    // 1. Tentukan apakah ini respons SUKSES berdasarkan adanya 'token'
    //    (Karena server TIDAK mengirimkan 'code' atau 'data').

    if (obj.containsKey('token')) {
      // Ini adalah respons sukses login (Status HTTP 200)

      // Ambil user ID dan konversi ke int (perlu penanganan null/error parsing)
      int? parsedUserID;
      if (obj['user'] != null && obj['user']['id'] != null) {
          try {
              parsedUserID = int.parse(obj['user']['id'].toString());
          } catch (e) {
              // Handle jika parsing ID gagal
          }
      }

      return Login(
        // Inject nilai code dan status yang diharapkan oleh login_page.dart
        code: 200, 
        status: true,
        
        // Ambil data dari root object
        token: obj['token'],
        userID: parsedUserID,
        userEmail: obj['user'] != null ? obj['user']['email'] : null,
      );

    } else {
      // Ini adalah respons GAGAL (Meskipun status HTTP 200, tidak ada token)
      // Gunakan nilai 'code' atau default error code jika ada.
      return Login(
        code: obj['code'] ?? 401, // Jika server menyediakan code kegagalan, gunakan; jika tidak, default 401.
        status: obj['status'] ?? false,
      );
    }
  }
}