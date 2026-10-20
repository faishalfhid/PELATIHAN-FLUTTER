import 'package:flutter/material.dart';
import 'Widget/ModalWidget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: LoginPage());
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isHidden = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Text Input Apps"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),

        children: [
          TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            autocorrect: false,
            decoration: InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              prefixIcon: Padding(
                padding: EdgeInsetsGeometry.all(5),
                child: Icon(Icons.group),
              ),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            controller: passwordController,
            autocorrect: false,
            textInputAction: TextInputAction.done,
            obscureText: isHidden,
            decoration: InputDecoration(
              labelText: "Password",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              prefixIcon: Padding(
                padding: EdgeInsetsGeometry.all(5),
                child: Icon(Icons.password),
              ),
              suffixIcon: Padding(
                padding: EdgeInsetsGeometry.all(5),
                child: IconButton(
                  onPressed: () {
                    if (isHidden == true) {
                      isHidden = false;
                    } else {
                      isHidden = true;
                    }
                    setState(() {});
                  },
                  icon: Icon(Icons.visibility),
                ),
              ),
            ),
          ),
          SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => ModalWidget(
                  emailController: emailController,
                  passwordController: passwordController,
                ),
              );
            },

            child: Text("LOGIN", style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
