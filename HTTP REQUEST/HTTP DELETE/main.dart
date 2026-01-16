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
  late String dataName;

  @override
  void initState() {
    dataName = "Belum ada data";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HTTP Delete Apps"),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () async {
              var myresponse = await myhttp.get(
                Uri.parse("https://dummyjson.com/users/5"),
              );
              Map<String, dynamic> data = json.decode(myresponse.body);
              setState(() {
                dataName = "Akun: ${data["firstName"]} ${data["lastName"]}";
              });
            },
            icon: Icon(Icons.download),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Center(child: Text(dataName)),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              var response = await myhttp.delete(
                Uri.parse("https://dummyjson.com/users/1"),
              );
              Map<String, dynamic> data = json.decode(response.body);
              if (response.statusCode == 200) {
                setState(() {
                  dataName = "Data berhasil terhapus pada ${data["deletedOn"]}";
                });
              }
            },
            child: Text("Hapus Data"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
