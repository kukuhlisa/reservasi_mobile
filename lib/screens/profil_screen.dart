import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/api_service.dart';
import 'login_screen.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() =>
      _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {

  final apiService = ApiService();

  final nameController = TextEditingController();
  final nimController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  bool isLoading = true;
  int? userId;

  File? selectedImage;
  String? photoUrl;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    try {
      final prefs =
          await SharedPreferences.getInstance();

      userId = prefs.getInt('user_id');

      print("USER ID = $userId");

      if (userId == null) {
        setState(() {
          isLoading = false;
        });

        return;
      }

      final data =
          await apiService.getProfile(
        userId!,
      );

      nameController.text =
          data['name'];

      nimController.text =
          data['nim'];

      emailController.text =
          data['email'];

      phoneController.text =
          data['phone'];

      photoUrl = data['photo'];

      setState(() {
        isLoading = false;
      });

    } catch (e) {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  Future<void> saveProfile() async {
    try {
      await apiService.updateProfile(
        userId!,
        nameController.text,
        nimController.text,
        emailController.text,
        phoneController.text,
      );

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Profil berhasil diperbarui',
          ),
        ),
      );

    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  Future<void> logout() async {
    final prefs =
        await SharedPreferences.getInstance();

    // hanya hapus token
    await prefs.remove('token');
    await prefs.remove('user_id');

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const LoginScreen(),
      ),
      (route) => false,
    );
  }

Future<void> pickImage() async {
  final picker = ImagePicker();

  final pickedFile = await picker.pickImage(
    source: ImageSource.gallery,
  );

  if (pickedFile != null) {
    try {
      print("PATH = ${pickedFile.path}");

      await apiService.uploadPhoto(
        userId!,
        pickedFile.path,
      );

      print("UPLOAD BERHASIL");

      await loadProfile();

    } catch (e) {
      print("ERROR UPLOAD = $e");
    }
  }
}

  @override
  void dispose() {
    nameController.dispose();
    nimController.dispose();
    emailController.dispose();
    phoneController.dispose();

    super.dispose();
  }

Widget buildField({
  required TextEditingController controller,
  required String label,
  TextInputType keyboardType =
      TextInputType.text,
}) {
  return Column(
    crossAxisAlignment:
        CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black54,
        ),
      ),

      const SizedBox(height: 8),

      TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: label,
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 16,
          ),
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    ],
  );
}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      appBar: AppBar(
        title: const Text('Profil'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
  child: SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Container(
  width: double.infinity,
  padding: const EdgeInsets.all(24),
  decoration: BoxDecoration(
    color: Colors.grey.shade300,
    borderRadius: BorderRadius.circular(30),
  ),

  child: Column(
    children: [

      /// FOTO PROFIL
      Stack(
        alignment: Alignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white,
            backgroundImage: selectedImage != null
                ? FileImage(selectedImage!)
                : (photoUrl != null
                    ? NetworkImage(photoUrl!)
                    : null) as ImageProvider?,
            child: selectedImage == null &&
                    photoUrl == null
                ? const Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.grey,
                  )
                : null,
          ),

          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: pickImage,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),

      const SizedBox(height: 20),

      const Text(
        "Foto Profil",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
      ),

      const SizedBox(height: 4),

      const Text(
        "Kelola informasi akun Anda",
        style: TextStyle(
          fontSize: 14,
          color: Colors.black54,
        ),
      ),

      const SizedBox(height: 30),

      buildField(
        controller: nameController,
        label: "Nama Lengkap",
      ),

      const SizedBox(height: 16),

      buildField(
        controller: nimController,
        label: "NIM",
      ),

      const SizedBox(height: 16),

      buildField(
        controller: emailController,
        label: "Email",
        keyboardType: TextInputType.emailAddress,
      ),

      const SizedBox(height: 16),

      buildField(
        controller: phoneController,
        label: "Nomor WhatsApp",
        keyboardType: TextInputType.phone,
      ),

      const SizedBox(height: 30),

      // Tombol Simpan
      SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton(
          onPressed: saveProfile,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(18),
            ),
          ),
          child: const Text(
            "Simpan",
          ),
        ),
      ),

      const SizedBox(height: 15),

      // Tombol Logout
            // Tombol Logout
            SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton.icon(
          onPressed: logout,
          icon: const Icon(Icons.logout),
          label: const Text("Logout"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        ),
      ),
    ],
  ),
), // Container
      ), // Padding
    ), // SingleChildScrollView
  ), // SafeArea
    );
  }
}