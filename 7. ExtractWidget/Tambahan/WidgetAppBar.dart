import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key, required this.judul});

  final String judul;

  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // leading: Icon(Icons.camera),
      title: Text(judul),
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,

      actions: [
        IconButton(
          onPressed: () {
            print("Tombol ditekan");
          },
          icon: Icon(Icons.search),
        ),
      ],
    );
  }
}
