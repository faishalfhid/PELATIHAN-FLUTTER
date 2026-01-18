## 🔹 STEP 1 — Import yang dibutuhkan

```dart
import 'dart:convert';
import 'package:belajar_flutter/HTTP/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as myhttp;
```

**Penjelasan:**

* `material.dart` → membangun UI
* `get.dart` → widget `GetApp` (GET data sebelumnya)
* `http` → mengirim request PUT/PATCH
* `dart:convert` → decode response JSON

---

## 🔹 STEP 2 — Entry point aplikasi

Setiap aplikasi Flutter **harus** punya `main()`.

```dart
void main() {
  runApp(MyApp());
}
```

➡️ Menjalankan widget utama (`MyApp`)

---

## 🔹 STEP 3 — Widget utama (Stateless)

Karena `MyApp` **tidak menyimpan data**, gunakan `StatelessWidget`.

```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
```

**Tugas MyApp:**

* Membungkus aplikasi
* Menentukan halaman awal

---

## 🔹 STEP 4 — Buat halaman utama (Stateful)

Karena:

* input TextField berubah
* loading berubah
* hasil response berubah

maka **harus `StatefulWidget`**.

```dart
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
```

---

## 🔹 STEP 5 — Siapkan State + controller input

```dart
class _HomePageState extends State<HomePage> {
  TextEditingController firstNameC = TextEditingController();
  TextEditingController emailC = TextEditingController();

  bool isLoading = false;
  String hasilResponse = "Belum ada data";
```

**Fungsi masing-masing:**

* `TextEditingController` → mengambil input user
* `isLoading` → kontrol loading indicator
* `hasilResponse` → menampilkan hasil update

---

## 🔹 STEP 6 — Bangun kerangka halaman (`Scaffold`)

```dart
return Scaffold(
  appBar: AppBar(
    title: Text("HTTP PUT/PATCH"),
    centerTitle: true,
  ),
```

➡️ Judul halaman menandakan fitur **update data**

---

## 🔹 STEP 7 — Body + ListView

```dart
body: Padding(
  padding: const EdgeInsets.all(20),
  child: ListView(
    children: [
```

➡️ `ListView` dipilih supaya aman dari overflow

---

## 🔹 STEP 8 — Tampilkan data lama (GET)

```dart
GetApp(),
SizedBox(height: 20),
```

➡️ Widget ini:

* mengambil data lama
* menjadi pembanding sebelum update

---

## 🔹 STEP 9 — TextField Nama Depan

```dart
TextField(
  controller: firstNameC,
  autocorrect: false,
  keyboardType: TextInputType.text,
  decoration: InputDecoration(
    labelText: "Nama Depan",
    border: OutlineInputBorder(),
  ),
),
```

➡️ Input nama baru yang akan dikirim ke server

---

## 🔹 STEP 10 — TextField Email

```dart
SizedBox(height: 20),
TextField(
  controller: emailC,
  autocorrect: false,
  keyboardType: TextInputType.numberWithOptions(decimal: true),
  decoration: InputDecoration(
    labelText: "Email",
    border: OutlineInputBorder(),
  ),
),
```

📌 *Catatan:*
KeyboardType ini **sebenarnya kurang tepat untuk email**, tapi sesuai dengan kode yang sedang dipelajari.

---

## 🔹 STEP 11 — Tombol Simpan (PUT/PATCH)

Karena ada request HTTP, fungsi harus `async`.

```dart
ElevatedButton(
  onPressed: () async {
```

---

## 🔹 STEP 12 — Aktifkan loading

```dart
setState(() {
  isLoading = true;
});
```

➡️ Loading muncul sebelum request dikirim

---

## 🔹 STEP 13 — Kirim request PUT ke API

```dart
var myresponse = await myhttp.put(
  Uri.parse("https://dummyjson.com/users/2"),
  body: {
    "firstName": firstNameC.text,
    "email": emailC.text,
  },
);
```

**Makna PUT/PATCH:**

* Mengubah data yang sudah ada
* Berdasarkan `id = 2`

---

## 🔹 STEP 14 — Decode response JSON

```dart
Map<String, dynamic> data =
    json.decode(myresponse.body) as Map<String, dynamic>;
```

➡️ Response diubah dari JSON ke Map

---

## 🔹 STEP 15 — Matikan loading + update UI

```dart
setState(() {
  isLoading = false;
  hasilResponse =
      "ID: ${data['id']} | Nama: ${data['firstName']} | Email: ${data['email']}";
});
```

📌 **Semua perubahan UI harus lewat `setState()`**

---

## 🔹 STEP 16 — Tampilkan hasil setelah update

```dart
SizedBox(height: 50),
Center(child: Text("Data setelah diupdate (PUT/PATCH)")),
Divider(color: Colors.black),
SizedBox(height: 10),
```

➡️ Memberi pemisah visual antara form & hasil

---

## 🔹 STEP 17 — Conditional loading / hasil data

```dart
Center(
  child: Column(
    children: [
      if (isLoading)
        CircularProgressIndicator()
      else
        Text(hasilResponse, style: TextStyle(fontSize: 24)),
    ],
  ),
),
```

➡️ Saat request berjalan → loading
➡️ Saat selesai → tampil hasil update

---

## 🧠 Alur Singkat (Mental Model)

```
GET data lama
 ↓
User isi data baru
 ↓
Klik Simpan
 ↓
Loading aktif
 ↓
HTTP PUT/PATCH
 ↓
Decode JSON
 ↓
setState()
 ↓
Loading mati & hasil tampil
```
