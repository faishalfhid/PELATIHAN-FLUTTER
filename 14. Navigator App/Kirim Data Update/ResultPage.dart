import 'package:flutter/material.dart';
import 'package:belajar_flutter_inixindo/Widget/WidgetAppBar.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key, required this.num});

  final int num;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(judul: "Result Page"),
      body: Center(child: Text("Count: $num")),
    );
  }
}
