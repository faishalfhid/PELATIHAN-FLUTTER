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
          title: Text("Layouting Apps (Row)"),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Container(
                height: 200,
                width: 200,
                color: Colors.red,
                child: Center(
                  child: Text(
                    "Box Merah",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Container(
                height: 200,
                width: 200,
                color: Colors.amber,
                child: Center(
                  child: Text(
                    "Box Kuning",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Container(
                height: 200,
                width: 200,
                color: Colors.green,
                child: Center(
                  child: Text(
                    "Box Hijau",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Container(
                height: 200,
                width: 200,
                color: Colors.red,
                child: Center(
                  child: Text(
                    "Box Merah",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Container(
                height: 200,
                width: 200,
                color: Colors.amber,
                child: Center(
                  child: Text(
                    "Box Kuning",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Container(
                height: 200,
                width: 200,
                color: Colors.green,
                child: Center(
                  child: Text(
                    "Box Hijau",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
