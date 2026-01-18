## 🔹 STEP 1 — Import yang dibutuhkan

```dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as myhttp;
```

**Kenapa perlu ini?**

* `material.dart` → membangun tampilan (TextField, Button, Scaffold)
* `http` → mengirim request POST ke API
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

## 🔹 STEP 3 — Widget utama (Stateless)

`MyApp` tidak menyimpan data apa pun, jadi cukup `StatelessWidget`.

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

## 🔹 STEP 4 — Buat halaman utama (Stateful)

Karena nanti:

* isi TextField berubah
* hasil response API berubah

maka **harus** menggunakan `StatefulWidget`.

```dart
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
```

➡️ UI-nya relatif tetap, **datanya dinamis**

---

## 🔹 STEP 5 — Buat State + TextEditingController

Di sinilah kita **menyiapkan input form**.

```dart
class _HomePageState extends State<HomePage> {
  TextEditingController firstNameC = TextEditingController();
  TextEditingController lastNameC = TextEditingController();
  TextEditingController ageC = TextEditingController();

  String hasilResponse = "Belum ada data";
```

**Penjelasan singkat:**

* `TextEditingController` → mengambil nilai dari TextField
* `hasilResponse` → menampilkan hasil dari API ke layar

---

## 🔹 STEP 6 — Bangun kerangka tampilan (`Scaffold`)

Mulai dari struktur dasar halaman.

```dart
return Scaffold(
  appBar: AppBar(
    title: Text("HTTP Post Apps"),
    centerTitle: true,
  ),
```

➡️ `Scaffold` = kerangka utama halaman

---

## 🔹 STEP 7 — Body + Padding + ListView

Supaya tampilan rapi dan aman saat keyboard muncul.

```dart
body: Padding(
  padding: const EdgeInsets.all(20),
  child: ListView(
    children: [
```

➡️ `ListView` dipilih agar **tidak overflow**

---

## 🔹 STEP 8 — TextField Nama Depan

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

➡️ Nilai input akan diambil lewat `firstNameC.text`

---

## 🔹 STEP 9 — TextField Nama Belakang

```dart
SizedBox(height: 20),
TextField(
  controller: lastNameC,
  autocorrect: false,
  keyboardType: TextInputType.text,
  decoration: InputDecoration(
    labelText: "Nama Belakang",
    border: OutlineInputBorder(),
  ),
),
```

---

## 🔹 STEP 10 — TextField Umur

```dart
SizedBox(height: 20),
TextField(
  controller: ageC,
  autocorrect: false,
  keyboardType: TextInputType.numberWithOptions(decimal: false),
  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
  decoration: InputDecoration(
    labelText: "Umur",
    border: OutlineInputBorder(),
  ),
),
```

➡️ Umur dikirim sebagai **INTEGER**, sehingga koma tidak diizinkan

---

## 🔹 STEP 11 — Tombol submit (awal masih tanpa logic)

```dart
SizedBox(height: 20),
ElevatedButton(
  onPressed: () async {
```

Karena nanti akan ada `await`, maka **wajib async**.

---

## 🔹 STEP 12 — Kirim data ke API (HTTP POST)

```dart
var myresponse = await myhttp.post(
  Uri.parse("https://dummyjson.com/users/add"),
  body: {
    "firstName": firstNameC.text,
    "lastName": lastNameC.text,
    "age": ageC.text,
  },
);
```

➡️ Data dikirim dari:

* TextField → Controller → body request

---

## 🔹 STEP 13 — Decode response JSON

```dart
Map<String, dynamic> data =
    json.decode(myresponse.body) as Map<String, dynamic>;
```

Contoh response API:

```json
{
  "firstName": "John",
  "lastName": "Doe",
  "age": 25
}
```

➡️ Diubah menjadi `Map<String, dynamic>`

---

## 🔹 STEP 14 — Update UI pakai `setState`

```dart
setState(() {
  hasilResponse =
      "${data['firstName']} ${data['lastName']} - Umur ${data['age']}";
});
```

📌 **Tanpa `setState()` → UI tidak akan berubah**

---

## 🔹 STEP 15 — Tampilkan hasil response ke layar

```dart
SizedBox(height: 50),
Divider(color: Colors.black),
SizedBox(height: 10),
Center(
  child: Text(hasilResponse),
),
```

➡️ Setelah POST berhasil, hasil langsung tampil

---

## 🧠 Alur Singkat (Mental Model)

```
User isi form
 ↓
Klik tombol
 ↓
HTTP POST
 ↓
Tunggu response (await)
 ↓
Decode JSON
 ↓
setState()
 ↓
UI update otomatis
```

---

Kalau kamu mau, berikutnya aku bisa:

* 🧪 Tambahkan validasi form
* 📦 Refactor ke UserModel
* 🧼 Pisahkan API ke service
* 🧑‍🏫 Jadikan versi materi ajar (slide / modul)

Tinggal bilang mau lanjut ke mana 👍
