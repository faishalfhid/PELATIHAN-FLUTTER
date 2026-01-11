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
          title: Text("Layouting Apps (Stack)"),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Container(height: 200, width: 200, color: Colors.red),
            Container(height: 180, width: 180, color: Colors.amber),
            Container(height: 150, width: 150, color: Colors.green),
          ],
        ),
      ),
    );
  }
}
