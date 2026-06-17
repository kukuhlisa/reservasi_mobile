import 'package:flutter/material.dart';

class RiwayatScreen extends StatelessWidget {
  const RiwayatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Riwayat Antrian",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black),
            onPressed: () {
              // Aksi untuk logout jika diperlukan
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // BAR PENCARIAN (SEARCH BAR)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Cari",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // DAFTAR KARTU RIWAYAT
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  buildHistoryCard(
                    title: "Pembayaran UKT",
                    date: "Senin, 1 April 2026",
                    time: "08.00 - 12.00 WIB",
                  ),
                  buildHistoryCard(
                    title: "Pendaftaran Magang dan PKL",
                    date: "Kamis, 2 Maret 2026",
                    time: "08.00 - 12.00 WIB",
                  ),
                  buildHistoryCard(
                    title: "Pembayaran UKT",
                    date: "Senin, 5 Mei 2026",
                    time: "13.00 - 15.00 WIB",
                  ),
                ],
              ),
            ),

            // DEKORASI ILUSTRASI ORANG DI BAGIAN BAWAH (Opsional)
            Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.only(right: 30, bottom: 10),
              child: const Icon(
                Icons.accessibility_new, // Pengganti sementara ilustrasi vector mockup
                size: 60,
                color: Colors.black26,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // FUNGSI PEMBANTU UNTUK MEMBUAT KARTU RIWAYAT KUSTOM
  Widget buildHistoryCard({
    required String title,
    required String date,
    required String time,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFCECECE), // Latar belakang abu-abu sesuai mockup mockup
        borderRadius: BorderRadius.circular(35), // Melengkung oval sempurna
        border: Border.all(color: Colors.black54, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // SIMULASI DUA PREVIEW DOKUMEN (KOTAK PUTIH KIRI)
          Row(
            children: [
              Container(
                width: 40,
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.black26),
                ),
                child: const Icon(Icons.description, size: 20, color: Colors.grey),
              ),
              const SizedBox(width: 4),
              Container(
                width: 40,
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.black26),
                ),
                child: const Icon(Icons.assignment_turned_in, size: 20, color: Colors.grey),
              ),
            ],
          ),

          const SizedBox(width: 16),

          // INFORMASI TEKS UTAMA
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Hari, Tanggal : $date",
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "Jam : $time",
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}