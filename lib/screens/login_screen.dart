import 'package:flutter/material.dart';

import '../services/api_service.dart';
import 'dashboard_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {
  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  final apiService = ApiService();

  bool isLoading = false;
  String selectedRole = 'mahasiswa';

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    setState(() {
      isLoading = true;
    });

    try {
      final result = await apiService.login(
        emailController.text.trim(),
        passwordController.text,
        selectedRole,
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => DashboardScreen(
            name: result['user']['name'],
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            e.toString().replaceFirst(
              'Exception: ',
              '',
            ),
          ),
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  InputDecoration fieldDecoration(
      String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding:
          const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      border: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width =
        MediaQuery.of(context).size.width
            .clamp(320.0, 390.0);

    final height =
        MediaQuery.of(context).size.height
            .clamp(650.0, 844.0);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor:
          const Color(0xffF2F2F2),

      body: Stack(
        children: [
          Positioned(
            top: -width * 0.2,
            left: -width * 0.2,
            child: Container(
              width: width * 0.6,
              height: width * 0.6,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                shape: BoxShape.circle,
              ),
            ),
          ),

          Positioned(
            bottom: -width * 0.2,
            right: -width * 0.2,
            child: Container(
              width: width * 0.6,
              height: width * 0.6,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                shape: BoxShape.circle,
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding:
                  EdgeInsets.symmetric(
                horizontal: width * 0.08,
              ),
              child: Column(
                children: [
                  SizedBox(
                      height: height * 0.08),

                  Text(
                    "ANTRE.in",
                    style: TextStyle(
                      fontSize: width * 0.11,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -2,
                    ),
                  ),
                  SizedBox(
                      height: height * 0.03),

                  Align(
                    alignment:
                        Alignment.centerRight,
                    child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.black54,
                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius
                                  .circular(
                                      20),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const RegisterScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Daftar",
                        style: TextStyle(
                            color:
                                Colors.white),
                      ),
                    ),
                  ),

                  Container(
                    width: width * 0.85,
                    padding: EdgeInsets.all(
                        width * 0.05),
                    decoration: BoxDecoration(
                      color:
                          Colors.grey.shade300,
                      borderRadius:
                          BorderRadius
                              .circular(25),
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                      children: [
                        Text(
                          "LOGIN",
                          style: TextStyle(
                            fontSize:
                                width * 0.06,
                            fontWeight:
                                FontWeight
                                    .bold,
                          ),
                        ),

                        SizedBox(
                            height:
                                height * 0.025),

                        DropdownButtonFormField<String>(
                          value: selectedRole,
                          decoration: fieldDecoration(
                            "Pilih Role",
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: 'mahasiswa',
                              child: Text('Mahasiswa'),
                            ),
                            DropdownMenuItem(
                              value: 'admin',
                              child: Text('Admin'),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              selectedRole = value!;
                            });
                          },
                        ),

                        SizedBox(
                          height: height * 0.015,
                        ),

                        TextField(
                          controller:
                              emailController,
                          decoration:
                              fieldDecoration(
                                  "Email"),
                        ),

                        SizedBox(
                            height:
                                height * 0.015),

                        TextField(
                          controller:
                              passwordController,
                          obscureText: true,
                          decoration:
                              fieldDecoration(
                                  "Password"),
                        ),

                        SizedBox(
                            height:
                                height * 0.02),

                        const Center(
                          child: Text(
                            "Belum memiliki akun?",
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                      height: height * 0.03),

                  SizedBox(
                    width: width * 0.35,
                    height: height * 0.055,
                    child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.white,
                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius
                                  .circular(
                                      25),
                        ),
                      ),
                      onPressed: isLoading
                          ? null
                          : login,
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : const Text(
                              "Masuk",
                              style: TextStyle(
                                color:
                                    Colors.black,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}