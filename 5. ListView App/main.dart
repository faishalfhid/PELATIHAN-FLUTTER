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
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("ListView App"),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Container(height: 200, width: 200, color: Colors.red),
            Container(height: 200, width: 200, color: Colors.amber),
            Container(height: 200, width: 200, color: Colors.green),
            Container(height: 200, width: 200, color: Colors.red),
            Container(height: 200, width: 200, color: Colors.amber),
            Container(height: 200, width: 200, color: Colors.green),
          ],
        ),
      ),
    );
  }
}
