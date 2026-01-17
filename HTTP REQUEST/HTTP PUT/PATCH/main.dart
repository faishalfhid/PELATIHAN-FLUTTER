import 'dart:convert';
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
  TextEditingController lastNameC = TextEditingController();
  TextEditingController emailC = TextEditingController();

  late String body;
  late String id;
  late String name;
  late String email;

  void initState() {
    // TODO: implement initState
    id = "belum ada data";
    name = "belum ada data";
    email = "belum ada data";
    body = "belum ada data";
    super.initState();
  }

  String hasilResponse = "Belum ada data";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HTTP PUT"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("ID: " + id, style: TextStyle(fontSize: 20)),
                Text("Nama: " + name, style: TextStyle(fontSize: 20)),
                Text("Email: " + email, style: TextStyle(fontSize: 20)),
                ElevatedButton(
                  onPressed: () async {
                    var myresponse = await myhttp.get(
                      Uri.parse("https://dummyjson.com/users/1"),
                    );
                    if (myresponse.statusCode == 200) {
                      // berhasil get data
                      print("Berhasil GET Data");
                      Map<String, dynamic> data =
                          json.decode(myresponse.body) as Map<String, dynamic>;
                      setState(() {
                        id = data["id"].toString();
                        name = data["firstName"].toString();
                        email = data["email"].toString();
                      });
                    } else {
                      print("Error ${myresponse.statusCode}");
                      setState(() {
                        body = "Error ${myresponse.statusCode}";
                      });
                    }
                  },
                  child: Text("GET DATA"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
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
              controller: lastNameC,
              autocorrect: false,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Nama Belakang",
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
                var myresponse = await myhttp.put(
                  Uri.parse("https://dummyjson.com/users/1"),
                  body: {
                    "firstName": firstNameC.text,
                    "lastName": lastNameC.text,
                    "age": emailC.text,
                  },
                );

                Map<String, dynamic> data =
                    json.decode(myresponse.body) as Map<String, dynamic>;

                setState(() {
                  hasilResponse =
                      "${data['firstName']} ${data['lastName']} | Email: ${data['age']}";
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
            Center(child: Text("Data setelah diupdate (PUT)")),
            Divider(color: Colors.black),
            SizedBox(height: 10),
            Center(child: Text(hasilResponse, style: TextStyle(fontSize: 24))),
          ],
        ),
      ),
    );
  }
}
