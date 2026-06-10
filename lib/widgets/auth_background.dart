import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;

  const AuthBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: Stack(
        children: [

          // Lingkaran atas
          Positioned(
            top: -80,
            left: -80,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 50,
                  )
                ],
              ),
            ),
          ),

          // Lingkaran bawah
          Positioned(
            bottom: -100,
            right: -100,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 50,
                  )
                ],
              ),
            ),
          ),

          SafeArea(
            child: child,
          ),
        ],
      ),
    );
  }
}