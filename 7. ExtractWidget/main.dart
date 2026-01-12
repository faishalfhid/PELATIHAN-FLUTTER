import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Extract Widget App"),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        body: ListView(
          children: [
            KotakWarna(warna: Colors.red, tulisan: "Container 1"),
            KotakWarna(warna: Colors.yellow, tulisan: "Container 2"),
            KotakWarna(warna: Colors.green, tulisan: "Container 3"),
            KotakWarna(warna: Colors.red, tulisan: "Container 4"),
            KotakWarna(warna: Colors.yellow, tulisan: "Container 5"),
            KotakWarna(warna: Colors.green, tulisan: "Container 6"),
          ],
        ),
      ),
    );
  }
}

class KotakWarna extends StatelessWidget {
  const KotakWarna({super.key, required this.warna, required this.tulisan});

  final Color warna;
  final String tulisan;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: this.warna,
      child: Center(child: Text(this.tulisan)),
    );
  }
}
