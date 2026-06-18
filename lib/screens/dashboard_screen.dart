import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),

          child: Column(
            children: [

              // HEADER
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
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ProfilScreen(),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.grey.shade200,
                      child: const Icon(Icons.person),
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
                imagePath: "assets/images/pembayaran.png", // Menggunakan path gambar .png
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
                imagePath: "assets/images/administrasi.png", // Menggunakan path gambar .png
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

                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue.shade100,
                        child: const Icon(
                          Icons.person,
                        ),
                      ),
                      title: const Text("A001"),
                      subtitle: const Text("Menunggu"),
                    ),

                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue.shade100,
                        child: const Icon(
                          Icons.person,
                        ),
                      ),
                      title: const Text("A002"),
                      subtitle: const Text("Menunggu"),
                    ),

                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue.shade100,
                        child: const Icon(
                          Icons.person,
                        ),
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

        onTap: (index) {
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ProfilScreen(),
                ),
              );
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

  // UPDATE: Fungsi pembantu diubah menggunakan Image.asset dan transparan CircleAvatar
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
              backgroundColor: const Color(0xFFE8EAF6), // Warna latar belakang pastel lembut untuk ikon gambar
              child: ClipOval(
                child: Image.asset(
                  imagePath,
                  width: 36,
                  height: 36,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    // Fallback jika file gambar tidak ditemukan atau salah ketik path
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