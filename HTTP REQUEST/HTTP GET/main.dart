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
  late String body;
  late String id;
  late String name;
  late String email;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    id = "belum ada data";
    name = "belum ada data";
    email = "belum ada data";
    body = "belum ada data";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Http GET Apps"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("ID: " + id, style: TextStyle(fontSize: 20)),
            Text("Nama: " + name, style: TextStyle(fontSize: 20)),
            Text("Email: " + email, style: TextStyle(fontSize: 20)),
            if (isLoading)
              Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(),
              ),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });

                var myresponse = await myhttp.get(
                  Uri.parse("https://dummyjson.com/users/2"),
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
                    isLoading = false;
                  });
                } else {
                  print("Error ${myresponse.statusCode}");
                  setState(() {
                    body = "Error ${myresponse.statusCode}";
                    isLoading = false;
                  });
                }
              },
              child: Text("GET DATA"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                id = "belum ada data";
                name = "belum ada data";
                email = "belum ada data";
                body = "belum ada data";
                setState(() {});
              },
              child: Text("Reset Data"),
            ),
          ],
        ),
      ),
    );
  }
}
