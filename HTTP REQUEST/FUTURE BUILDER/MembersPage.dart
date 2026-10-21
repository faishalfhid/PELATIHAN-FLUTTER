import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:belajar_flutter_inixindo/Widget/WidgetAppBar.dart';
import 'package:http/http.dart' as http;

class MembersPage extends StatefulWidget {
  const MembersPage({super.key});

  @override
  State<MembersPage> createState() => _MembersPageState();
}

class _MembersPageState extends State<MembersPage> {
  late Future<List> futureUsers;

  Future<List> fetchUsers() async {
    var response = await http.get(Uri.parse("https://dummyjson.com/users"));
    if (response.statusCode == 200) {
      print("Berhasil GET Data");
      List data = (json.decode(response.body) as Map<String, dynamic>)["users"];
      return data;
    } else {
      print("Error ${response.statusCode}");
      throw Exception("Gagal memuat data");
    }
  }

  @override
  void initState() {
    futureUsers = fetchUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(judul: "Future Builder Apps"),
      body: FutureBuilder<List>(
        future: futureUsers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            List users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                var user = users[index];
                return ListTile(
                  title: Text(user["firstName"]),
                  subtitle: Text(user["email"]),
                );
              },
            );
          }
        },
      ),
    );
  }
}
