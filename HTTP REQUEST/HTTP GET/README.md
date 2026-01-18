## 🔹 STEP 1 — Import yang dibutuhkan

```dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as myhttp;
```

**Kenapa perlu ini?**

* `material.dart` → komponen UI Flutter
* `http` → melakukan request API
* `dart:convert` → mengubah JSON → Map

---

## 🔹 STEP 2 — Entry point aplikasi

Setiap aplikasi Flutter **wajib** punya `main()`.

```dart
void main() {
  runApp(MyApp());
}
```

➡️ Menjalankan widget utama aplikasi (`MyApp`)

---

## 🔹 STEP 3 — Widget utama (Stateless)

Karena `MyApp` **tidak berubah-ubah**, pakai `StatelessWidget`.

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

* Bungkus aplikasi
* Tentukan halaman awal (`HomePage`)

---

## 🔹 STEP 4 — Buat halaman utama (Stateful)

Karena **data API akan berubah**, kita butuh `StatefulWidget`.

```dart
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
```

➡️ UI-nya statis, **datanya dinamis**

---

## 🔹 STEP 5 — Buat State + variabel data

Di sinilah **data dari API disimpan**.

```dart
class _HomePageState extends State<HomePage> {
  late String body;
  late String id;
  late String name;
  late String email;
```

Kenapa `late`?

* Variabel **pasti diisi**, tapi **bukan saat deklarasi**

---

## 🔹 STEP 6 — Inisialisasi nilai awal (`initState`)

Supaya tidak `null` saat pertama kali UI dirender.

```dart
@override
void initState() {
  id = "belum ada data";
  name = "belum ada data";
  email = "belum ada data";
  body = "belum ada data";
  super.initState();
}
```

➡️ UI aman sebelum API dipanggil

---

## 🔹 STEP 7 — Bangun tampilan (`build`)

Struktur dasar halaman.

```dart
return Scaffold(
  appBar: AppBar(
    title: Text("Http GET Apps"),
    centerTitle: true,
  ),
  body: Center(
```

➡️ Scaffold = kerangka halaman

---

## 🔹 STEP 8 — Tampilkan data ke layar

Gunakan variabel state.

```dart
Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Text("ID: " + id),
    Text("Nama: " + name),
    Text("Email: " + email),
```

➡️ Saat `setState()` dipanggil → UI otomatis update

---

## 🔹 STEP 9 — Tombol untuk GET data

Karena ada `await`, maka **HARUS async**.

```dart
ElevatedButton(
  onPressed: () async {
```

---

## 🔹 STEP 10 — Panggil API

```dart
var myresponse = await myhttp.get(
  Uri.parse("https://dummyjson.com/users/2"),
);
```

➡️ `await` → tunggu server merespons
➡️ `myresponse` berisi:

* `statusCode`
* `body`

---

## 🔹 STEP 11 — Cek status response

```dart
if (myresponse.statusCode == 200) {
```

✔️ 200 = sukses
❌ selain itu = error

---

## 🔹 STEP 12 — Decode JSON

```dart
Map<String, dynamic> data =
  json.decode(myresponse.body) as Map<String, dynamic>;
```

Contoh JSON dari API:

```json
{
  "id": 2,
  "firstName": "Sheldon",
  "email": "sheldon@example.com"
}
```

➡️ Diubah jadi `Map`

---

## 🔹 STEP 13 — Update UI pakai `setState`

```dart
setState(() {
  id = data["id"].toString();
  name = data["firstName"].toString();
  email = data["email"].toString();
});
```

📌 **Tanpa `setState` → UI tidak berubah**

---

## 🔹 STEP 14 — Handle error

```dart
else {
  setState(() {
    body = "Error ${myresponse.statusCode}";
  });
}
```

➡️ Antisipasi jika API gagal

---

## 🧠 Alur Singkat (Mental Model)

```
Klik tombol
 ↓
HTTP GET
 ↓
Tunggu response (await)
 ↓
Decode JSON
 ↓
setState()
 ↓
UI update otomatis
```