import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  final String name;

  const DashboardScreen({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Center(
        child: Text(
          'Selamat datang, $name',
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}