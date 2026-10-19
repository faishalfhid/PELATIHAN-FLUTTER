import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Insta App"),
          backgroundColor: Colors.white,
          // foregroundColor: Colors.white,
          leading: FlutterLogo(),
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              height: 110,
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 8,
                ),
                scrollDirection: Axis.horizontal,
                children: [
                  Container(width: 100, height: 100, color: Colors.red),
                  Container(width: 100, height: 100, color: Colors.yellow),
                  Container(width: 100, height: 100, color: Colors.green),
                  Container(width: 100, height: 100, color: Colors.red),
                  Container(width: 100, height: 100, color: Colors.yellow),
                  Container(width: 100, height: 100, color: Colors.green),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(8),
                children: [
                  Container(width: 100, height: 300, color: Colors.red),
                  SizedBox(height: 8),
                  Container(width: 100, height: 300, color: Colors.yellow),
                  SizedBox(height: 8),
                  Container(width: 100, height: 300, color: Colors.green),
                  SizedBox(height: 8),
                  Container(width: 100, height: 300, color: Colors.red),
                  SizedBox(height: 8),
                  Container(width: 100, height: 300, color: Colors.yellow),
                  SizedBox(height: 8),
                  Container(width: 100, height: 300, color: Colors.green),
                  SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
