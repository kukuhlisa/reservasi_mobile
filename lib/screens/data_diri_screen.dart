import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart'; // Pastikan path ini sesuai dengan struktur projekmu
import 'upload_administrasi_screen.dart';

class DataDiriScreen extends StatefulWidget {
  final String jenisLayanan;
  final List<String> syarat;

  const DataDiriScreen({
    super.key,
    required this.jenisLayanan,
    required this.syarat,
  });

  @override
  State<DataDiriScreen> createState() => _DataDiriScreenState();
}

class _DataDiriScreenState extends State<DataDiriScreen> {
  final ApiService _apiService = ApiService();

  final namaController = TextEditingController();
  final nimController = TextEditingController();
  final prodiController = TextEditingController();

  bool _isLoading = true; // State untuk indikator loading data

  @override
  void initState() {
    super.initState();
    _loadUserProfile(); // Panggil otomatis saat halaman dibuka
  }

  // Fungsi mengambil data profil dari server Laravel
  Future<void> _loadUserProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // Ambil user_id yang disimpan saat login (sesuaikan key-nya dengan login_screen kamu)
      int? userId = prefs.getInt('user_id'); 

      if (userId != null) {
        final profileData = await _apiService.getProfile(userId);

        // Set isi controller berdasarkan response API profil
        setState(() {
          namaController.text = profileData['name'] ?? '';
          nimController.text = profileData['nim'] ?? '';
          
          // Jika di Laravel kamu ada kolom prodi/program_studi silakan disesuaikan key-nya
          prodiController.text = profileData['prodi'] ?? profileData['program_studi'] ?? '';
          
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Berikan info jika gagal fetch data otomatis (opsional, user tetap bisa ketik manual)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memuat data otomatis: $e')),
      );
    }
  }

  @override
  void dispose() {
    namaController.dispose();
    nimController.dispose();
    prodiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Diri"),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(), // Tampilkan loading spinner saat fetch data
            )
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  TextField(
                    controller: namaController,
                    decoration: const InputDecoration(
                      labelText: "Nama",
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: nimController,
                    decoration: const InputDecoration(
                      labelText: "NIM",
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: prodiController,
                    decoration: const InputDecoration(
                      labelText: "Program Studi",
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => UploadAdministrasiScreen(
                              jenisLayanan: widget.jenisLayanan,
                              syarat: widget.syarat,
                              // Opsional: Jika di screen berikutnya kamu butuh data inputan ini,
                              // tinggal tambahkan parameter penampung di UploadAdministrasiScreen:
                              // nama: namaController.text,
                              // nim: nimController.text,
                            ),
                          ),
                        );
                      },
                      child: const Text("Lanjutkan"),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}