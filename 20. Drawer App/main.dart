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
      home: DrawerWidgetApp(),
    );
  }
}

class DrawerWidgetApp extends StatelessWidget {
  const DrawerWidgetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Drawer App"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.all(20),
              color: Colors.blue,
              width: double.infinity,
              height: 150,
              child: Text(
                "Dashboard Menu",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(0),
                children: [
                  ListTile(
                    onTap: () => print("klik-1"),
                    leading: Icon(Icons.abc),
                    title: Text("Tes"),
                    trailing: Icon(Icons.arrow_right_outlined),
                  ),
                  ListTile(
                    onTap: () => print("klik-1"),
                    leading: Icon(Icons.abc),
                    title: Text("Tes"),
                  ),
                  ListTile(
                    onTap: () => print("klik-1"),
                    leading: Icon(Icons.abc),
                    title: Text("Tes"),
                  ),
                  ListTile(
                    onTap: () => Navigator.pop(context),
                    leading: Icon(Icons.close_fullscreen_rounded),
                    title: Text("Tutup"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
