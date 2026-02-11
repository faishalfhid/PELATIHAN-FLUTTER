import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:faker/faker.dart';

void main() {
  var faker = new Faker();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  int currentIndex = 0;
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) => ListTile(
          title: Text("${faker.person.name()}"),
          subtitle: Text("${faker.internet.email()}"),
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            backgroundImage: NetworkImage(
              "https://picsum.photos/id/${index + 870}/200/300",
            ),
          ),
        ),
      ),
      Center(child: Text("Discovery Page")),
      Center(child: Text("Add Page")),
      Center(child: Text("Message Page")),
      Center(child: Text("Profile Page")),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("Faker Apps"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        leading: Icon(Icons.supervised_user_circle_sharp),
      ),
      body: widgets[currentIndex],
      bottomNavigationBar: ConvexAppBar(
        items: [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.map, title: 'Discovery'),
          TabItem(icon: Icons.add, title: 'Add'),
          TabItem(icon: Icons.message, title: 'Message'),
          TabItem(icon: Icons.people, title: 'Profile'),
        ],
        initialActiveIndex: 0,
        onTap: (int i) => setState(() {
          currentIndex = i;
        }),
      ),
    );
  }
}
