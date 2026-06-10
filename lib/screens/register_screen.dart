import 'package:flutter/material.dart';

import '../services/api_service.dart';
import 'dashboard_screen.dart';

class RegisterScreen
    extends StatefulWidget {
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
      resizeToAvoidBottomInset: true,
      backgroundColor:
          const Color(0xffF2F2F2),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
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
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Masuk",
                    style: TextStyle(
                        color:
                            Colors.white),
                  ),
                ),
              ),

              Container(
                width: width * 0.85,
                padding:
                    EdgeInsets.all(width * 0.05),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius:
                      BorderRadius.circular(
                          25),
                ),
                child: Column(
                  children: [
                    Text(
                      "DAFTAR",
                      style: TextStyle(
                        fontSize:
                            width * 0.06,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    SizedBox(
                        height:
                            height * 0.02),

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

                    const SizedBox(height: 12),

                    buildField(
                    passwordController,
                    "Password",
                    obscure: true,
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
                              .circular(25),
                    ),
                  ),
                  onPressed: isLoading
                      ? null
                      : register,
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text(
                          "Daftar",
                          style: TextStyle(
                            color:
                                Colors.black,
                          ),
                        ),
                ),
              ),

              SizedBox(
                  height: height * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}