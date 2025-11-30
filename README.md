# Feidinata Artandi - H1D023115
# Tugas 8 - Pertemuan 10
<img width="366" height="820" alt="Tambah Produk" src="https://github.com/user-attachments/assets/03daaea9-7d8f-4b7d-b421-d0d9573eb78f" />
<img width="372" height="818" alt="List Produk" src="https://github.com/user-attachments/assets/d4c1f627-d5fe-4a44-9cd5-5b42dc968aad" />

Penjelasan Halaman (Widget) Aplikasi Toko Kita
1. LoginPage (Halaman Login)
Halaman ini bertanggung jawab untuk memvalidasi identitas pengguna agar dapat mengakses fitur aplikasi yang dilindungi.

Tujuan: Memungkinkan pengguna masuk ke aplikasi dengan memasukkan Email dan Password.

Komponen Utama:

_emailTextField() & _passwordTextField(): Dua field input dengan validasi dasar (tidak boleh kosong).

_formKey: Digunakan untuk mengelola state formulir dan memicu validasi ketika tombol Login ditekan.

_buttonLogin(): Tombol yang, saat ditekan, menjalankan validasi formulir (_formKey.currentState!.validate()). Logika autentikasi (memeriksa Email/Password ke server) akan ditambahkan di sini.

_menuRegistrasi(): Tautan yang mengarahkan pengguna ke RegistrasiPage jika belum memiliki akun.

2. RegistrasiPage (Halaman Registrasi)
Halaman ini digunakan untuk membuat akun pengguna baru dan mengumpulkan informasi dasar mereka.

Tujuan: Mendaftarkan pengguna baru ke sistem.

Komponen Utama:

_namaTextField(): Mengumpulkan nama pengguna dengan validasi minimal 3 karakter.

_emailTextField(): Mengumpulkan Email dengan validasi tidak boleh kosong dan validasi format Email menggunakan regex.

_passwordTextField(): Mengumpulkan Password dengan validasi minimal 6 karakter.

_passwordKonfirmasiTextField(): Memastikan Password yang dimasukkan sama persis dengan field Password sebelumnya.

_buttonRegistrasi(): Tombol yang memicu validasi semua field. Logika pengiriman data ke server untuk menyimpan akun baru akan ditambahkan di sini.

3. ProdukPage (Halaman Daftar Produk)
Halaman ini berfungsi sebagai layar utama yang menampilkan daftar semua produk yang tersedia.

Tujuan: Menampilkan daftar produk dan menyediakan navigasi ke halaman lain seperti form penambahan produk atau detail produk.

Komponen Utama:

AppBar dengan Ikon Tambah (Icons.add): Digunakan untuk menavigasi ke ProdukForm (halaman tambah/edit produk).

Drawer: Menyediakan menu tambahan, seperti Logout (yang logikanya masih perlu ditambahkan).

ListView: Digunakan untuk menampilkan produk secara berulang.

ItemProduk: Ini adalah widget terpisah yang bertugas menampilkan satu item produk (nama dan harga) dalam bentuk Card dan mengarahkan ke ProdukDetail ketika diklik (onTap).

Data Dummy: Saat ini, data produk (ID 1, 2, 3) masih berupa data dummy yang dimasukkan langsung ke kode.

# Tugas 9 - Pertemuan 11

<img width="366" height="813" alt="image" src="https://github.com/user-attachments/assets/a7cb8f0f-8b82-436a-87bb-91d3f8f03665" />
🔐 Proses Login
Proses login memungkinkan pengguna diverifikasi oleh server menggunakan email dan password yang dimasukkan, dan kemudian mendapatkan token otorisasi.

a. Mengisi Form Login
Ini adalah tampilan di mana pengguna memasukkan kredensialnya.

Langkah 1: Pengguna memasukkan Email (dedes@email.com dalam contoh) dan Password.

Langkah 2: Pengguna menekan tombol Login.

b. Memproses Permintaan dan Menerima Respons
Setelah tombol Login ditekan, fungsi _submit() pada _LoginPageState akan dipanggil.

1. Kode Permintaan di login_page.dart (_submit)
Kode ini memanggil bloc untuk mengirim data ke server dan menangani responsnya.

// login_page.dart, di dalam _submit()
void _submit() {
  // ... (mengatur _isLoading = true)

  LoginBloc.login(
    email: _emailTextboxController.text,
    password: _passwordTextboxController.text,
  ).then(
    (value) async {
      // Cek apakah login berhasil (kode 200)
      if (value.code == 200) { 
        // Lakukan navigasi jika sukses
        await UserInfo().setToken(value.token.toString());
        await UserInfo().setUserID(int.parse(value.userID.toString()));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProdukPage()),
        );
      } else {
        // Tampilkan dialog gagal jika kode bukan 200
        showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
            description: "Login gagal, silahkan coba lagi",
          ),
        );
      }
    },
    // ... (onError block)
  );
  // ... (mengatur _isLoading = false)
}

2. Kode Komunikasi ke API di login_bloc.dart
Kode ini (dengan asumsi perbaikan yang telah dilakukan) bertanggung jawab untuk mengirim data ke API dan mengurai respons.

// login_bloc.dart
static Future<Login> login({String? email, String? password}) async {
  String apiUrl = ApiUrl.login;
  var body = {"email": email, "password": password};
  
  // Mengirim data ke server
  var response = await Api().post(apiUrl, body); 
  var jsonObj = json.decode(response.body); 

  // Mengembalikan objek Login yang sudah di-parse
  return Login.fromJson(jsonObj); 
}

Tentu, saya akan jelaskan proses Login dan CRUD (Create, Read, Update, Delete) untuk data Produk dalam bentuk langkah per langkah, termasuk tangkapan layar (diasumsikan) dan kode yang relevan dari aplikasi Anda.

🔐 Proses Login
Proses login memungkinkan pengguna diverifikasi oleh server menggunakan email dan password yang dimasukkan, dan kemudian mendapatkan token otorisasi.

a. Mengisi Form Login
Ini adalah tampilan di mana pengguna memasukkan kredensialnya.

Langkah 1: Pengguna memasukkan Email (dedes@email.com dalam contoh) dan Password.

Langkah 2: Pengguna menekan tombol Login.

b. Memproses Permintaan dan Menerima Respons
Setelah tombol Login ditekan, fungsi _submit() pada _LoginPageState akan dipanggil.

1. Kode Permintaan di login_page.dart (_submit)
Kode ini memanggil bloc untuk mengirim data ke server dan menangani responsnya.

Dart

// login_page.dart, di dalam _submit()
void _submit() {
  // ... (mengatur _isLoading = true)

  LoginBloc.login(
    email: _emailTextboxController.text,
    password: _passwordTextboxController.text,
  ).then(
    (value) async {
      // Cek apakah login berhasil (kode 200)
      if (value.code == 200) { 
        // Lakukan navigasi jika sukses
        await UserInfo().setToken(value.token.toString());
        await UserInfo().setUserID(int.parse(value.userID.toString()));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProdukPage()),
        );
      } else {
        // Tampilkan dialog gagal jika kode bukan 200
        showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
            description: "Login gagal, silahkan coba lagi",
          ),
        );
      }
    },
    // ... (onError block)
  );
  // ... (mengatur _isLoading = false)
}
2. Kode Komunikasi ke API di login_bloc.dart
Kode ini (dengan asumsi perbaikan yang telah dilakukan) bertanggung jawab untuk mengirim data ke API dan mengurai respons.

Dart

// login_bloc.dart
static Future<Login> login({String? email, String? password}) async {
  String apiUrl = ApiUrl.login;
  var body = {"email": email, "password": password};
  
  // Mengirim data ke server
  var response = await Api().post(apiUrl, body); 
  var jsonObj = json.decode(response.body); 

  // Mengembalikan objek Login yang sudah di-parse
  return Login.fromJson(jsonObj); 
}
3. Hasil (Popup Berhasil/Gagal)
Jika Berhasil: Aplikasi akan menyimpan token dan langsung navigasi ke halaman ProdukPage.
Jika Gagal: Aplikasi akan menampilkan popup peringatan.

📦 Proses CRUD Data Produk
CRUD (Create, Read, Update, Delete) adalah empat operasi dasar yang dilakukan pada data. Semua operasi ini dilakukan melalui API dan diorganisir menggunakan ProdukBloc.
<img width="370" height="819" alt="image" src="https://github.com/user-attachments/assets/c6f94300-1cd7-4229-914d-430c3e706293" />
<img width="371" height="820" alt="image" src="https://github.com/user-attachments/assets/8c6e048b-1ca0-4141-b934-3c0e9d848dc7" />
<img width="368" height="819" alt="image" src="https://github.com/user-attachments/assets/1ff7556e-8374-4bc9-a5b6-c6a0e2e33e93" />
<img width="370" height="820" alt="image" src="https://github.com/user-attachments/assets/03db7899-c8ab-4beb-b038-3b803d735db2" />
<img width="367" height="821" alt="image" src="https://github.com/user-attachments/assets/ae505cb9-02cf-47c8-81e2-285be6814d0e" />
<img width="365" height="819" alt="image" src="https://github.com/user-attachments/assets/29b9e001-b418-49fb-9b31-064c692cfe2d" />

1. Proses Tambah Data Produk (CREATE)
Proses ini dimulai dari ProdukForm saat pengguna menekan tombol Simpan.

a. Penjelasan Proses
Pengguna mengisi form dengan Kode Produk, Nama Produk, dan Harga.

Data divalidasi oleh form (misalnya, memastikan semua kolom terisi).

Fungsi _submit() (di ProdukFormState) dipanggil untuk membuat objek Produk baru.

Data dikirim ke server melalui ProdukBloc.addProduk().

Setelah sukses, aplikasi kembali ke ProdukPage.

b. Kode Permintaan di produk_bloc.dart

// produk_bloc.dart
static Future addProduk({Produk? produk}) async {
  String apiUrl = ApiUrl.createProduk;

  var body = {
    "kode_produk": produk!.kodeProduk,
    "nama_produk": produk.namaProduk,
    "harga": produk.hargaProduk.toString()
  };

  // Mengirim data menggunakan HTTP POST
  var response = await Api().post(apiUrl, body); 
  
  // Penanganan respons (asumsi Anda membuang error/status HTTP di sini)
  if (response.statusCode != 200) {
      throw Exception('Gagal menambah produk. Status: ${response.statusCode}');
  }
  
  var jsonObj = json.decode(response.body);
  return jsonObj['status']; // Mengembalikan status sukses dari server
}

2. Proses Tampil Data Produk (READ)
Proses ini terjadi saat ProdukPage dimuat.

a. Penjelasan Proses
Saat ProdukPage dibuka, ia memanggil ProdukBloc.getProduks() untuk mengambil daftar produk.

Bloc mengambil data dari server menggunakan method GET.

Data JSON yang diterima di-decode dan diubah menjadi list objek Produk.

List tersebut ditampilkan di interface pengguna (biasanya dalam ListView atau FutureBuilder).

b. Kode Permintaan di produk_bloc.dart

// produk_bloc.dart
static Future<List<Produk>> getProduks() async {
  String apiUrl = ApiUrl.listProduk;
  
  // Mengambil data dari server menggunakan HTTP GET
  var response = await Api().get(apiUrl); 
  
  if (response.statusCode != 200) {
    throw Exception('Gagal memuat produk. Status: ${response.statusCode}');
  }

  var jsonObj = json.decode(response.body);
  // Parsing list produk dari kunci 'data'
  List<dynamic> listProduk = (jsonObj as Map<String, dynamic>)['data']; 
  List<Produk> produks = [];
  
  for (int i = 0; i < listProduk.length; i++) {
    produks.add(Produk.fromJson(listProduk[i]));
  }
  return produks;
}

3. Proses Ubah Data Produk (UPDATE)
Proses ini mirip dengan CREATE, tetapi menggunakan ID produk yang sudah ada.

a. Penjelasan Proses
Pengguna menekan tombol EDIT di ProdukDetail, menavigasi ke ProdukForm yang sudah terisi data.

Pengguna mengubah data dan menekan Simpan.

Data yang diubah, bersama dengan ID produk, dikirim ke server menggunakan method PUT.

Server memperbarui data produk di database.

b. Kode Permintaan di produk_bloc.dart

// produk_bloc.dart
static Future updateProduk({required Produk produk}) async {
  int? idProduk;
  try {
      idProduk = int.parse(produk.id ?? '');
  } catch (e) {
      throw Exception('ID produk tidak valid untuk diupdate.');
  }
  
  String apiUrl = ApiUrl.updateProduk(idProduk); 
  
  var body = {
    "kode_produk": produk.kodeProduk,
    "nama_produk": produk.namaProduk,
    "harga": produk.hargaProduk.toString()
  };
  
  // Mengirim data menggunakan HTTP PUT ke URL spesifik ID
  var response = await Api().put(apiUrl, jsonEncode(body)); 
  
  if (response.statusCode != 200) {
    throw Exception('Gagal update produk. Status: ${response.statusCode}');
  }

  var jsonObj = json.decode(response.body);
  return jsonObj['status'];
}

4. Proses Hapus Data Produk (DELETE)
Proses ini menghapus data berdasarkan ID produk.

a. Penjelasan Proses
Pengguna menekan tombol DELETE di ProdukDetail.

Popup konfirmasi muncul.

Setelah mengkonfirmasi Ya, fungsi confirmHapus() dipanggil.

ID produk dikirim ke server melalui method DELETE.

Setelah sukses, aplikasi kembali ke ProdukPage.

b. Kode Permintaan di produk_bloc.dart (Perbaikan untuk Empty JSON)

// produk_bloc.dart
static Future<bool> deleteProduk({int? id}) async {
  if (id == null) {
    throw Exception('ID produk untuk dihapus tidak boleh null.');
  }
  
  String apiUrl = ApiUrl.deleteProduk(id);
  
  // Mengirim permintaan penghapusan menggunakan HTTP DELETE
  var response = await Api().delete(apiUrl); 

  if (response.statusCode != 200) {
      // Jika status bukan 200, lempar error
      throw Exception('Gagal menghapus produk. Status: ${response.statusCode}');
  }

  // TANGANI RESPON KOSONG (Solusi untuk error JSON)
  if (response.body.isEmpty) {
    return true; // Anggap sukses jika status 200 dan body kosong
  }

  // Lanjutkan parsing hanya jika ada body
  try {
    var jsonObj = json.decode(response.body);
    // Ganti 'success' sesuai dengan properti sukses di API Anda
    return jsonObj['success'] ?? true; 
  } catch (e) {
      throw Exception('Gagal mengurai respons server setelah penghapusan: $e');
  }
}






