import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: DialogWidget());
  }
}

class DialogWidget extends StatelessWidget {
  const DialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dialog Apps"),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
      ),
      body: Container(
        alignment: Alignment.center,
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(12),
                ),
                title: Text("Ini Judul"),
                content: Text("Ini adalah isi dari sebuah dialog"),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Iya", style: TextStyle(color: Colors.white)),
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.green),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Tidak"),
                  ),
                ],
              ),
            );
          },
          child: Text("Show Dialog", style: TextStyle(color: Colors.white)),
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.blue),
          ),
        ),
      ),
    );
  }
}
