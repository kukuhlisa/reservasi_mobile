import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // DITAMBAHKAN
import '../services/api_service.dart'; // DITAMBAHKAN (Sesuaikan path folder ApiService Anda)

import 'riwayat_screen.dart';
import 'tambah_screen.dart';
import 'monitoring_antrian_screen.dart';
import 'profil_screen.dart';
import 'pembayaran_screen.dart';
import 'administrasi_screen.dart';

class DashboardScreen extends StatefulWidget {
  final String name;

  const DashboardScreen({
    super.key,
    required this.name,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedIndex = 0;
  
  // DITAMBAHKAN: Variabel untuk melacak data profile foto
  final ApiService apiService = ApiService();
  String? photoUrl;
  bool isLoadingPhoto = true;

  @override
  void initState() {
    super.initState();
    loadUserPhoto(); // Panggil fungsi memuat foto saat dashboard dibuka
  }

  // DITAMBAHKAN: Fungsi untuk mengambil data profil ter-update dari database
  Future<void> loadUserPhoto() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('user_id');

      if (userId != null) {
        final data = await apiService.getProfile(userId);
        if (!mounted) return;
        setState(() {
          photoUrl = data['photo']; // URL penuh yang sudah diperbaiki oleh ApiService
          isLoadingPhoto = false;
        });
      } else {
        if (!mounted) return;
        setState(() {
          isLoadingPhoto = false;
        });
      }
    } catch (e) {
      print("Gagal memuat foto profil di beranda: $e");
      if (!mounted) return;
      setState(() {
        isLoadingPhoto = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Siapkan ImageProvider secara dinamis
    ImageProvider? profileImage;
    if (photoUrl != null && photoUrl!.isNotEmpty) {
      profileImage = NetworkImage(photoUrl!);
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),

          child: Column(
            children: [

              // HEADER (DENGAN FOTO PROFIL DINAMIS)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "ANTRE.in",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () async {
                      // PERBAIKAN: Menggunakan 'await' saat push ke halaman profil.
                      // Ketika user kembali dari halaman profil, dashboard akan me-refresh foto terbarunya.
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ProfilScreen(),
                        ),
                      );
                      loadUserPhoto(); // Auto-refresh foto setelah kembali dari halaman Profil
                    },
                    child: CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage: profileImage, // PERBAIKAN: Menampilkan foto dari database
                      child: profileImage == null
                          ? const Icon(Icons.person, color: Colors.grey)
                          : null,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Beranda",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Halo, ${widget.name}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "Mahasiswa",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // SEARCH
              TextField(
                decoration: InputDecoration(
                  hintText: "Cari",
                  prefixIcon: const Icon(Icons.search),

                  filled: true,
                  fillColor: Colors.white,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // KARTU TANGGAL
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Column(
                  children: [
                    const Icon(
                      Icons.calendar_month,
                      size: 40,
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "Rabu",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Text(
                      "17 Juni 2026",
                    ),

                    const SizedBox(height: 12),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // PEMBAYARAN (.PNG ASSET)
              buildMenuCard(
                title: "Pembayaran",
                subtitle: "Layanan pembayaran UKT, KKL, dan administrasi lainnya.",
                imagePath: "assets/images/pembayaran.png", // <--- HANYA STRING PATH SAJA
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PembayaranScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 15),

              // ADMINISTRASI (.PNG ASSET)
              buildMenuCard(
                title: "Administrasi",
                subtitle: "Surat aktif kuliah, legalisir dan administrasi mahasiswa.",
                imagePath: "assets/images/administrasi.png", // <--- HANYA STRING PATH SAJA
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AdministrasiScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              // DAFTAR ANTRIAN
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Text(
                      "Daftar Antrian",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    // PERBAIKAN: Mengganti ikon default di antrian dengan foto profil pengguna jika tersedia
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue.shade100,
                        backgroundImage: profileImage,
                        child: profileImage == null
                            ? const Icon(Icons.person, color: Colors.blue)
                            : null,
                      ),
                      title: const Text("A001"),
                      subtitle: const Text("Menunggu"),
                    ),

                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue.shade100,
                        backgroundImage: profileImage,
                        child: profileImage == null
                            ? const Icon(Icons.person, color: Colors.blue)
                            : null,
                      ),
                      title: const Text("A002"),
                      subtitle: const Text("Menunggu"),
                    ),

                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue.shade100,
                        backgroundImage: profileImage,
                        child: profileImage == null
                            ? const Icon(Icons.person, color: Colors.blue)
                            : null,
                      ),
                      title: const Text("A003"),
                      subtitle: const Text("Menunggu"),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // INFO LAYANAN
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),

                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      "Info Layanan",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 15),

                    Text(
                      "Senin - Jumat",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 5),

                    Text(
                      "08.00 - 12.00 WIB",
                    ),

                    Text(
                      "13.30 - 16.00 WIB",
                    ),

                    Divider(),

                    Text(
                      "Sabtu",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 5),

                    Text(
                      "08.00 - 12.00 WIB",
                    ),

                    Divider(),

                    Text(
                      "Minggu & Hari Libur",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 5),

                    Text("Tutup"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,

        onTap: (index) async {
          setState(() {
            selectedIndex = index;
          });

          switch (index) {
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const RiwayatScreen(),
                ),
              );
              break;

            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const TambahScreen(),
                ),
              );
              break;

            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const MonitoringAntrianScreen(),
                ),
              );
              break;

            case 4:
              // PERBAIKAN: Sama seperti AppBar, tambahkan penantian refresh data di sini
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ProfilScreen(),
                ),
              );
              loadUserPhoto();
              break;
          }
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "Riwayat",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: "Tambah",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monitor_heart),
            label: "Monitor",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profil",
          ),
        ],
      ),
    );
  }

  Widget buildMenuCard({
    required String title,
    required String subtitle,
    required String imagePath,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,

      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),

        child: Row(
          children: [

            CircleAvatar(
              radius: 28,
              backgroundColor: const Color(0xFFE8EAF6), 
              child: ClipOval(
                child: Image.asset(
                  imagePath,
                  width: 36,
                  height: 36,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.broken_image, size: 28);
                  },
                ),
              ),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}