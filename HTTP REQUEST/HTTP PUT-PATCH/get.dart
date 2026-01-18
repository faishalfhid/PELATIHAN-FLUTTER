import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as myhttp;

class GetApp extends StatefulWidget {
  const GetApp({super.key});

  @override
  State<GetApp> createState() => _GetAppState();
}

class _GetAppState extends State<GetApp> {
  late String body;
  late String id;
  late String name;
  late String email;
  bool isLoading =
      false; // Inisialisasi loading di awal sebagai false, agar tidak terlihat di awal

  @override
  void initState() {
    // TODO: implement initState
    id = "belum ada data";
    name = "belum ada data";
    email = "belum ada data";
    body = "belum ada data";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isLoading)
            CircularProgressIndicator()
          else ...[
            Text("ID: " + id, style: TextStyle(fontSize: 20)),
            Text("Nama: " + name, style: TextStyle(fontSize: 20)),
            Text("Email: " + email, style: TextStyle(fontSize: 20)),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  isLoading =
                      true; // Set state loading menjadi true ketika tombol get Data Ditekan (Mengubah tampilan menjadi loading)
                });
                var myresponse = await myhttp.get(
                  Uri.parse("https://dummyjson.com/users/2"),
                );
                if (myresponse.statusCode == 200) {
                  // berhasil get data
                  print("Berhasil GET Data");
                  Map<String, dynamic> data =
                      json.decode(myresponse.body) as Map<String, dynamic>;
                  setState(() {
                    isLoading =
                        false; // Loading selesai jika Data berhasil didapatkan
                    id = data["id"].toString();
                    name = data["firstName"].toString();
                    email = data["email"].toString();
                  });
                } else {
                  print("Error ${myresponse.statusCode}");
                  setState(() {
                    body = "Error ${myresponse.statusCode}";
                  });
                }
              },
              child: Text("GET DATA"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
