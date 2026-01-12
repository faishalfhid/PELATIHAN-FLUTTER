import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  List<KotakWarna> allItems = List.generate(
    10,
    (index) => KotakWarna(
      warna: Color.fromARGB(
        255,
        200 + Random().nextInt(256),
        200 + Random().nextInt(256),
        200 + Random().nextInt(256),
      ),
      tulisan: "Container ${index + 1}",
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Mapping Collections App"),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        body: SingleChildScrollView(child: Column(children: allItems)),
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
