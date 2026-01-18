## 🔹 STEP 1 — Import yang dibutuhkan

```dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as myhttp;
```

**Penjelasan:**

* `material.dart` → membangun tampilan UI
* `http` → mengirim request GET & DELETE
* `dart:convert` → mengubah JSON response menjadi Map

---

## 🔹 STEP 2 — Entry point aplikasi

Setiap aplikasi Flutter **wajib** punya fungsi `main()`.

```dart
void main() {
  runApp(MyApp());
}
```

➡️ Menjalankan widget utama aplikasi (`MyApp`)

---

## 🔹 STEP 3 — Widget utama (`StatelessWidget`)

Karena `MyApp` **tidak menyimpan data**, kita gunakan `StatelessWidget`.

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
* Menentukan halaman awal (`HomePage`)

---

## 🔹 STEP 4 — Halaman utama (`StatefulWidget`)

Karena:

* data user bisa berubah
* hasil DELETE bisa berubah

maka halaman **HARUS `StatefulWidget`**.

```dart
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
```

---

## 🔹 STEP 5 — State & variabel data

```dart
class _HomePageState extends State<HomePage> {
  late String dataName;
```

**Tujuan `dataName`:**

* Menyimpan teks hasil GET
* Menyimpan pesan setelah DELETE

---

## 🔹 STEP 6 — Inisialisasi data awal (`initState`)

```dart
@override
void initState() {
  dataName = "Belum ada data";
  super.initState();
}
```

📌 Kenapa ini penting?

* Supaya saat app pertama kali dibuka:

  * UI **tidak kosong**
  * Ada nilai default

---

## 🔹 STEP 7 — Bangun kerangka halaman (`Scaffold`)

```dart
return Scaffold(
  appBar: AppBar(
    title: Text("HTTP Delete Apps"),
    centerTitle: true,
    foregroundColor: Colors.white,
    backgroundColor: Colors.blue,
```

➡️ Judul AppBar menandakan fitur utama: **DELETE data**

---

## 🔹 STEP 8 — Tombol GET di AppBar (Icon Download)

```dart
actions: [
  IconButton(
    onPressed: () async {
```

📌 Kenapa `async`?
Karena `http.get()` adalah proses **asynchronous**.

---

## 🔹 STEP 9 — Ambil data user (GET)

```dart
var myresponse = await myhttp.get(
  Uri.parse("https://dummyjson.com/users/5"),
);
```

➡️ Mengambil data user dengan `id = 5`
➡️ `await` → menunggu response dari server

---

## 🔹 STEP 10 — Decode JSON response GET

```dart
Map<String, dynamic> data = json.decode(myresponse.body);
```

➡️ JSON string diubah menjadi `Map` agar bisa diakses

---

## 🔹 STEP 11 — Tampilkan hasil GET ke UI

```dart
setState(() {
  dataName = "Akun: ${data["firstName"]} ${data["lastName"]}";
});
```

📌 **Semua perubahan UI harus lewat `setState()`**

Hasil di layar:

```
Akun: John Doe
```

---

## 🔹 STEP 12 — Body halaman (`ListView`)

```dart
body: ListView(
  padding: EdgeInsets.all(20),
  children: [
```

➡️ `ListView` dipakai supaya aman dari overflow

---

## 🔹 STEP 13 — Tampilkan data user

```dart
Center(child: Text(dataName)),
```

➡️ Menampilkan:

* hasil GET
* atau pesan DELETE

---

## 🔹 STEP 14 — Tombol DELETE

```dart
ElevatedButton(
  onPressed: () async {
```

📌 DELETE adalah proses async → **harus `async`**

---

## 🔹 STEP 15 — Kirim request DELETE ke API

```dart
var response = await myhttp.delete(
  Uri.parse("https://dummyjson.com/users/1"),
);
```

➡️ Menghapus user dengan `id = 1`
➡️ DummyJSON hanya **simulasi**, tidak benar-benar menghapus data

---

## 🔹 STEP 16 — Decode response DELETE

```dart
Map<String, dynamic> data = json.decode(response.body);
```

Biasanya response DELETE berisi:

* `id`
* `isDeleted`
* `deletedOn`

---

## 🔹 STEP 17 — Cek status & update UI

```dart
if (response.statusCode == 200) {
  setState(() {
    dataName = "Data berhasil terhapus pada ${data["deletedOn"]}";
  });
}
```

📌 Jika DELETE berhasil:

```
Data berhasil terhapus pada 2024-xx-xx
```

---

## 🧠 Alur Logika (Mental Model)

```
App dibuka
 ↓
initState → "Belum ada data"
 ↓
Klik icon download
 ↓
HTTP GET → decode JSON → setState
 ↓
Klik tombol Hapus
 ↓
HTTP DELETE → decode JSON → setState
 ↓
Pesan berhasil ditampilkan
```
