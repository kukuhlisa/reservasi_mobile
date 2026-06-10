import 'package:flutter/material.dart';

class TambahScreen extends StatelessWidget {
  const TambahScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah'),
      ),
      body: const Center(
        child: Text(
          'Halaman Tambah',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}