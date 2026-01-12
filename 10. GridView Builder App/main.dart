import 'dart:math';

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
          title: Text("GridView Builder App"),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
          ),
          itemBuilder: (context, index) => Container(
            height: 200,
            width: 200,
            color: Color.fromARGB(
              255,
              200 + Random().nextInt(256),
              Random().nextInt(256),
              Random().nextInt(256),
            ),
            child: Center(child: Text("Container ${index + 1}")),
          ),
          itemCount: 50,
        ),
      ),
    );
  }
}
