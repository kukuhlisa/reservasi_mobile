import 'package:flutter/material.dart';

import '../services/api_service.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() =>
      _RegisterScreenState();
}

class _RegisterScreenState
    extends State<RegisterScreen> {
  final nameController =
      TextEditingController();

  final nimController =
      TextEditingController();

  final emailController =
      TextEditingController();

  final phoneController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  final apiService = ApiService();

  bool isLoading = false;
  String selectedRole = 'mahasiswa';

  @override
  void dispose() {
    nameController.dispose();
    nimController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> register() async {
    setState(() {
      isLoading = true;
    });

    try {
      final result =
          await apiService.register(
        nameController.text.trim(),
        nimController.text.trim(),
        emailController.text.trim(),
        phoneController.text.trim(),
        passwordController.text,
        selectedRole,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Registrasi berhasil, silakan login",
          ),
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginScreen(),
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

  Widget buildField(
    TextEditingController controller,
    String hint, {
    bool obscure = false,
  }) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        decoration:
            fieldDecoration(hint),
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
    backgroundColor: const Color(0xffF2F2F2),

    body: Stack(
      children: [
        Positioned(
          top: -90,
          left: -90,
          child: Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
          ),
        ),

        Positioned(
          bottom: -90,
          right: -90,
          child: Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
          ),
        ),

        SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.08,
            ),

            child: Column(
              children: [
                SizedBox(
                  height: height * 0.08,
                ),

                Text(
                  "ANTRE.in",
                  style: TextStyle(
                    fontSize: width * 0.11,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -2,
                  ),
                ),

                SizedBox(
                  height: height * 0.03,
                ),

                Container(
                  width: width * 0.85,
                  padding: EdgeInsets.all(
                    width * 0.05,
                  ),

                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius:
                        BorderRadius.circular(
                      25,
                    ),
                  ),

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [
                      Text(
                        "REGISTER",
                        style: TextStyle(
                          fontSize:
                              width * 0.06,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      SizedBox(
                        height:
                            height * 0.02,
                      ),

                      buildField(
                        nameController,
                        "Nama",
                      ),

                      buildField(
                        nimController,
                        "NIM",
                      ),

                      buildField(
                        emailController,
                        "Email",
                      ),

                      buildField(
                        phoneController,
                        "No HP",
                      ),

                      DropdownButtonFormField<
                          String>(
                        value: selectedRole,
                        decoration:
                            fieldDecoration(
                          "Pilih Role",
                        ),
                        items: const [
                          DropdownMenuItem(
                            value:
                                'mahasiswa',
                            child: Text(
                              'Mahasiswa',
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'admin',
                            child: Text(
                              'Admin',
                            ),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedRole =
                                value!;
                          });
                        },
                      ),

                      const SizedBox(
                        height: 12,
                      ),

                      buildField(
                        passwordController,
                        "Password",
                        obscure: true,
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment
                                .center,
                        children: [
                          const Text(
                            "Sudah memiliki akun? ",
                          ),

                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const LoginScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                color:
                                    Color(0xFF2F80ED),
                                fontWeight:
                                    FontWeight.bold,
                                decoration:
                                    TextDecoration
                                        .underline,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 15,
                      ),

                      Center(
                        child: SizedBox(
                          width:
                              width * 0.35,
                          height:
                              height * 0.055,

                          child:
                              ElevatedButton(
                            style:
                                ElevatedButton
                                    .styleFrom(
                              backgroundColor:
                                  Colors.white,
                              shape:
                                  RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius
                                        .circular(
                                  25,
                                ),
                              ),
                            ),

                            onPressed:
                                isLoading
                                    ? null
                                    : register,

                            child: isLoading
                                ? const CircularProgressIndicator()
                                : const Text(
                                    "Daftar",
                                    style:
                                        TextStyle(
                                      color:
                                          Colors.black,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: height * 0.05,
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