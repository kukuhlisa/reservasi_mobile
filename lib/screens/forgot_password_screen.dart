import 'package:flutter/material.dart';

import '../services/api_service.dart';
import 'login_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState
    extends State<ForgotPasswordScreen> {

  final apiService = ApiService();

  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  final passwordController =
      TextEditingController();

  final confirmPasswordController =
      TextEditingController();

  bool isLoading = false;

  int currentStep = 1;

  @override
  void dispose() {
    phoneController.dispose();
    otpController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
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

  Future<void> sendOtp() async {
  if (phoneController.text.trim().isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Nomor WhatsApp wajib diisi'),
      ),
    );
    return;
  }

  setState(() {
    isLoading = true;
  });

  try {
    final result = await apiService.sendOtp(
      phoneController.text.trim(),
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(result['message']),
      ),
    );

    setState(() {
      currentStep = 2;
    });
  } catch (e) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
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

Future<void> verifyOtp() async {
  if (otpController.text.trim().isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('OTP wajib diisi'),
      ),
    );
    return;
  }

  setState(() {
    isLoading = true;
  });

  try {
    final result = await apiService.verifyOtp(
      phoneController.text.trim(),
      otpController.text.trim(),
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(result['message']),
      ),
    );

    setState(() {
      currentStep = 3;
    });
  } catch (e) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
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

Future<void> resetPassword() async {
  if (passwordController.text.isEmpty ||
      confirmPasswordController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Password wajib diisi',
        ),
      ),
    );
    return;
  }

  if (passwordController.text !=
      confirmPasswordController.text) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Konfirmasi password tidak sesuai',
        ),
      ),
    );
    return;
  }

  setState(() {
    isLoading = true;
  });

  try {
    final result =
        await apiService.resetPassword(
      phoneController.text.trim(),
      otpController.text.trim(),
      passwordController.text,
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          result['message'],
        ),
      ),
    );

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const LoginScreen(),
      ),
      (route) => false,
    );
  } catch (e) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
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

  @override
Widget build(BuildContext context) {
  final width =
      MediaQuery.of(context).size.width
          .clamp(320.0, 390.0);

  final height =
      MediaQuery.of(context).size.height
          .clamp(650.0, 844.0);

  return Scaffold(
    backgroundColor:
        const Color(0xffF2F2F2),

    body: Stack(
      children: [
        Positioned(
          top: -120,
          left: -120,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
          ),
        ),

        Positioned(
          bottom: -180,
          right: -150,
          child: Container(
            width: 350,
            height: 350,
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
                BorderRadius.circular(25),
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                "LUPA PASSWORD",
                style: TextStyle(
                  fontSize: width * 0.06,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 25,
              ),

if (currentStep == 1) ...[
  TextField(
    controller: phoneController,
    keyboardType: TextInputType.phone,
    decoration: fieldDecoration(
      "Masukkan Nomor WhatsApp",
    ),
  ),

  const SizedBox(height: 20),

  Center(
    child: SizedBox(
      width: width * 0.45,
      height: height * 0.055,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(25),
          ),
        ),
        onPressed:
            isLoading ? null : sendOtp,
        child: isLoading
            ? const CircularProgressIndicator()
            : const Text(
                "Kirim OTP",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
      ),
    ),
  ),
],

              if (currentStep == 2) ...[
                TextField(
                  controller: otpController,
                  keyboardType:
                      TextInputType.number,
                  decoration: fieldDecoration(
                    "Masukkan OTP",
                  ),
                ),

                const SizedBox(height: 20),

                Center(
                  child: SizedBox(
                    width: width * 0.45,
                    height: height * 0.055,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(25),
                        ),
                      ),
                      onPressed:
                          isLoading ? null : verifyOtp,
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : const Text(
                              "Verifikasi OTP",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                    ),
                  ),
                ),
              ],

              if (currentStep == 3) ...[
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: fieldDecoration(
                    "Password Baru",
                  ),
                ),

                const SizedBox(height: 15),

                TextField(
                  controller:
                      confirmPasswordController,
                  obscureText: true,
                  decoration: fieldDecoration(
                    "Konfirmasi Password",
                  ),
                ),

                const SizedBox(height: 20),

                Center(
                  child: SizedBox(
                    width: width * 0.45,
                    height: height * 0.055,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(25),
                        ),
                      ),
                      onPressed:
                          isLoading
                              ? null
                              : resetPassword,
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : const Text(
                              "Reset Password",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                    ),
                  ),
                ),
              ],

              const SizedBox(
                height: 20,
              ),

              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                    );
                  },
                  child: const Text(
                    "Kembali ke Login",
                  ),
                ),
              ),
            ],
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
