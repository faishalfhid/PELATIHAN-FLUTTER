import 'dart:convert';
import 'package:belajar_flutter/HTTP/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as myhttp;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController firstNameC = TextEditingController();
  TextEditingController emailC = TextEditingController();

  bool isLoading = false;

  String hasilResponse = "Belum ada data";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HTTP PUT/PATCH"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            GetApp(),
            SizedBox(height: 20),
            TextField(
              controller: firstNameC,
              autocorrect: false,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Nama Depan",
                border: OutlineInputBorder(),
              ),
            ),
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                var myresponse = await myhttp.put(
                  Uri.parse("https://dummyjson.com/users/2"),
                  body: {"firstName": firstNameC.text, "email": emailC.text},
                );

                Map<String, dynamic> data =
                    json.decode(myresponse.body) as Map<String, dynamic>;

                setState(() {
                  isLoading = false;
                  hasilResponse =
                      "ID: ${data['id']} | Nama: ${data['firstName']} | Email: ${data['email']}";
                });
              },
              child: Text("Simpan Data"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(10),
                ),
              ),
            ),
            SizedBox(height: 50),
            Center(child: Text("Data setelah diupdate (PUT/PATCH)")),
            Divider(color: Colors.black),
            SizedBox(height: 10),
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
          ],
        ),
      ),
    );
  }
}
