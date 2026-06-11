import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState
    extends State<ForgotPasswordScreen> {

  final nimController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lupa Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nimController,
              decoration: const InputDecoration(
                labelText: "Masukkan NIM",
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                // nanti hubungkan ke API reset password
              },
              child: const Text(
                "Kirim Permintaan Reset",
              ),
            ),
          ],
        ),
      ),
    );
  }
}