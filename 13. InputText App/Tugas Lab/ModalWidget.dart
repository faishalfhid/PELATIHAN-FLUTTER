import 'package:flutter/material.dart';

class ModalWidget extends StatelessWidget {
  const ModalWidget({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Judul Dialog"),
      content: Text(
        "Email: ${emailController.text} \nPassword: ${passwordController.text}",
      ),
      actions: [
        ElevatedButton(onPressed: () {}, child: Text("No")),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Yes"),
        ),
      ],
    );
  }
}
