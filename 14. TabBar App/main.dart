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

class DialogWidget extends StatefulWidget {
  const DialogWidget({super.key});

  @override
  State<DialogWidget> createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<DialogWidget>
    with SingleTickerProviderStateMixin {
  late TabController tabController = TabController(length: 4, vsync: this);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Whatsapp"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Tab(icon: Icon(Icons.camera_alt, color: Colors.white)),
            Tab(icon: Icon(Icons.message, color: Colors.white)),
            Tab(
              icon: Icon(
                Icons.signal_wifi_statusbar_4_bar_outlined,
                color: Colors.white,
              ),
            ),
            Tab(icon: Icon(Icons.call, color: Colors.white)),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          Center(child: Text("Camera")),
          Center(child: Text("Pesan")),
          Center(child: Text("Status")),
          Center(child: Text("Panggilan")),
        ],
      ),
    );
  }
}
