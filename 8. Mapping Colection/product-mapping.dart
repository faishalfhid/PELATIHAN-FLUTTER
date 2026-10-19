import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

final List<String> products = [
  'Laptop',
  'Mouse',
  'Keyboard',
  'Monitor',
  'Headset',
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Daftar Produk')),
        body: const ListViewWidget(),
      ),
    );
  }
}

class ListViewWidget extends StatelessWidget {
  const ListViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final random = Random();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Kotak(
          warna: Color.fromARGB(
            255,
            200 + random.nextInt(56),
            random.nextInt(256),
            random.nextInt(256),
          ),
          tulisan: products[index],
        );
      },
    );
  }
}

class Kotak extends StatelessWidget {
  final Color warna;
  final String tulisan;

  const Kotak({super.key, required this.warna, required this.tulisan});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: const EdgeInsets.only(bottom: 12),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: warna,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        tulisan,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
