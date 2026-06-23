import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart'; // Pastikan path ini sesuai dengan struktur projekmu
import 'upload_persyaratan_screen.dart';

class DataDiriPembayaranScreen extends StatefulWidget {
  final String jenisPembayaran;
  final List<String> syarat;

  const DataDiriPembayaranScreen({
    super.key,
    required this.jenisPembayaran,
    required this.syarat,
  });

  @override
  State<DataDiriPembayaranScreen> createState() =>
      _DataDiriPembayaranScreenState();
}

class _DataDiriPembayaranScreenState
    extends State<DataDiriPembayaranScreen> {
  final ApiService _apiService = ApiService();

  final namaController = TextEditingController();
  final nimController = TextEditingController();
  final prodiController = TextEditingController();

  bool _isLoading = true; // State untuk indikator loading data

  @override
  void initState() {
    super.initState();
    _loadUserProfile(); // Ambil data profil otomatis saat halaman dimuat
  }

  Future<void> _loadUserProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      int? userId = prefs.getInt('user_id'); // Pastikan key sesuai dengan yang disimpan saat login

      if (userId != null) {
        final profileData = await _apiService.getProfile(userId);

        setState(() {
          namaController.text = profileData['name'] ?? '';
          nimController.text = profileData['nim'] ?? '';
          
          // Menyesuaikan key prodi dari response backend Laravel kamu
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
      // Menampilkan snackbar jika gagal load data, tetapi form tetap bisa diisi manual
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
        title: const Text(
          "Data Diri",
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(), // Tampilkan loading spinner selama fetch data
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
                            builder: (_) => UploadPersyaratanScreen(
                              jenisPembayaran: widget.jenisPembayaran,
                              syarat: widget.syarat,
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        "Lanjutkan",
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}