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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Faker Apps"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        leading: Icon(Icons.supervised_user_circle_sharp),
      ),
      body: ListView.builder(
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
    );
  }
}
