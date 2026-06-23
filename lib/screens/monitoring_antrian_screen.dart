import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class MonitoringAntrianScreen extends StatefulWidget {
  const MonitoringAntrianScreen({
    super.key,
  });

  @override
  State<MonitoringAntrianScreen> createState() =>
      _MonitoringAntrianScreenState();
}

class _MonitoringAntrianScreenState extends State<MonitoringAntrianScreen> {
  String nomor = "-";
  String jenis = "-";
  String status = "-";
  String sesi = "-";
  String lokasi = "-";
  String jam = "-";
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    loadData();
    // Jalankan fungsi loadData / panggil API tiap 5 detik otomatis
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      loadData(); // Ganti atau kombinasikan dengan fungsi fetch API kamu
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Hentikan timer agar tidak memory leak
    super.dispose();
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      nomor = prefs.getString('nomor_antrian') ?? '-';
      jenis = prefs.getString('jenis_pelayanan') ?? '-';
      status = prefs.getString('status_antrian') ?? '-';
      sesi = prefs.getString('sesi') ?? '-';
      lokasi = prefs.getString('lokasi') ?? '-';
      jam = prefs.getString('jam_pelayanan') ?? '-';
    });
  }

  // Fungsi untuk memundurkan halaman secara paksa ke halaman root paling dasar (Dashboard)
  void _backToDashboard(BuildContext context) {
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  // DITAMBAHKAN: Fungsi pembantu untuk menentukan warna teks status secara dinamis
  Color _getStatusColor(String statusText) {
    switch (statusText.toLowerCase()) {
      case 'sedang dilayani':
      case 'melayani':
        return Colors.blue.shade700;
      case 'selesai':
        return Colors.green.shade700;
      case 'batal':
        return Colors.red.shade700;
      case 'menunggu':
      default:
        return Colors.orange.shade700;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Kunci tombol back fisik HP Android
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _backToDashboard(context); // Jika diswipe back atau pencet tombol back HP, lari ke dashboard
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        appBar: AppBar(
          title: const Text(
            "Monitoring Antrean",
          ),
          centerTitle: true,
          // Kustomisasi tombol back panah kiri di AppBar
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => _backToDashboard(context),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const Text(
                      "Nomor Antrian Anda",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      nomor,
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Card(
                child: ListTile(
                  title: const Text(
                    "Jenis Pelayanan",
                  ),
                  subtitle: Text(jenis),
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text("Sesi"),
                  subtitle: Text(sesi),
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text("Status"),
                  subtitle: Text(
                    status,
                    style: TextStyle(
                      color: _getStatusColor(status),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Icon(
                    Icons.circle,
                    size: 14,
                    color: _getStatusColor(status),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text(
                    "Lokasi Pelayanan",
                  ),
                  subtitle: Text(
                    lokasi,
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text(
                    "Waktu Pelayanan",
                  ),
                  subtitle: Text(
                    jam,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}