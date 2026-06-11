import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      builder: (context, child) {
        return Scaffold(
          backgroundColor: const Color(0xFFE5E5E5),

          body: Center(
            child: Container(
              width: 390,
              height: 844,

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(30),

                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),

              clipBehavior: Clip.antiAlias,

              child: child,
            ),
          ),
        );
      },

      home: const WelcomeScreen(),
    );
  }
}