import 'package:flutter/material.dart';
import 'metode_pembayaran_screen.dart';

class PembayaranScreen extends StatelessWidget {
  const PembayaranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),

      appBar: AppBar(
        title: const Text("Pembayaran"),
        centerTitle: true,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          buildPembayaranCard(
            context: context,
            title: "Pembayaran UKT",
            description:
                "Pembayaran biaya operasional pendidikan rutin setiap semester.",
            syarat: [
              "KRS semester berjalan",
              "Tagihan akademik",
              "Bukti pembayaran",
            ],
            icon: Icons.payments,
          ),

          const SizedBox(height: 16),

          buildPembayaranCard(
            context: context,
            title: "Pembayaran KKL",
            description:
                "Pembayaran dana kegiatan Kuliah Kerja Lapangan.",
            syarat: [
              "Formulir KKL",
              "KTM aktif",
              "Bukti pembayaran",
            ],
            icon: Icons.school,
          ),

          const SizedBox(height: 16),

          buildPembayaranCard(
            context: context,
            title: "Pengajuan Keringanan UKT",
            description:
                "Pengajuan keringanan biaya pendidikan bagi mahasiswa yang memenuhi syarat.",
            syarat: [
              "Surat permohonan",
              "Slip gaji orang tua",
              "Kartu Keluarga",
            ],
            icon: Icons.description,
          ),

          const SizedBox(height: 16),

          buildPembayaranCard(
            context: context,
            title: "Pembayaran Non Akademik",
            description:
                "Pembayaran layanan dan kegiatan non akademik.",
            syarat: [
              "Form pengajuan",
              "Identitas mahasiswa",
            ],
            icon: Icons.receipt_long,
          ),
        ],
      ),
    );
  }

  Widget buildPembayaranCard({
    required BuildContext context,
    required String title,
    required String description,
    required List<String> syarat,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                child: Icon(icon),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            "Berkas Persyaratan",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          ...syarat.map(
            (item) => Padding(
              padding: const EdgeInsets.only(
                bottom: 4,
              ),
              child: Text("• $item"),
            ),
          ),

          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MetodePembayaranScreen(
                    jenisPembayaran: title,
                    ),
                  ),
                );
              },
              child: const Text("Antri"),
            ),
          ),
        ],
      ),
    );
  }
}