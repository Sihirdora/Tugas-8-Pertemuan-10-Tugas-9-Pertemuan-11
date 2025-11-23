# Feidinata Artandi - H1D023115

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
