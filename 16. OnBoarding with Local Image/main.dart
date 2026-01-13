import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: IntroScreen());
  }
}

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Title of introduction page",
          body: "Welcome to the app! This is a description of how it works.",
          image: Image(image: AssetImage("Assets/Images/welcome_image.jpg")),
        ),
        PageViewModel(
          title: "Halaman OnBoarding Ke-2",
          body: "Keterangan halaman OnBoarding ke-2.",
          image: Image(image: NetworkImage("https://picsum.photos/200/300")),
        ),
        PageViewModel(
          title: "Halaman OnBoarding Ke-3",
          body: "Keterangan halaman OnBoarding ke-3.",
          image: Image(image: NetworkImage("https://picsum.photos/200/400")),
        ),
      ],
      showBackButton: true,
      showNextButton: true,
      showSkipButton: true,
      skip: Text("Skip"),
      next: Icon(Icons.arrow_forward, size: 25),
      back: const Icon(Icons.arrow_back, size: 25),
      done: const Text("Done"),
      onDone: () {
        Navigator.of(
          context,
        ).pushReplacement(MaterialPageRoute(builder: (context) => HomeScren()));
      },
    );
  }
}

class HomeScren extends StatelessWidget {
  const HomeScren({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.navigation_outlined),
        title: Text("ObBoarding App"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("Halaman Home")),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (context) => ProductPage()));
              },
              child: Text("Next Page", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Navigation App"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("Halaman Produk")),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Kembali Page",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}
