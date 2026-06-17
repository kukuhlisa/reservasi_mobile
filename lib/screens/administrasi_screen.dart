import 'package:flutter/material.dart';

import 'data_diri_screen.dart';

class AdministrasiScreen extends StatelessWidget {
  const AdministrasiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text(
          "Administrasi",
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          buildCard(
            context,
            "Surat Aktif Kuliah",
            [
              "Fotokopi KTM",
              "Bukti pembayaran UKT",
              "Formulir permohonan",
            ],
          ),

          const SizedBox(height: 16),

          buildCard(
            context,
            "Legalisir Ijazah",
            [
              "Fotokopi Ijazah",
              "Fotokopi Transkrip Nilai",
            ],
          ),

          const SizedBox(height: 16),

          buildCard(
            context,
            "Pengajuan Cuti Kuliah",
            [
              "Surat Permohonan Cuti",
              "Transkrip Nilai",
            ],
          ),

          const SizedBox(height: 16),

          buildCard(
            context,
            "Pengajuan Skripsi / TA",
            [
              "Transkrip Nilai Terbaru",
              "Lembar Persetujuan Dosen",
              "Bukti Lunas Pembayaran",
            ],
          ),

          const SizedBox(height: 16),

          buildCard(
            context,
            "Penggantian KTM",
            [
              "Surat Kehilangan",
              "Pas Foto 3x4",
              "Fotokopi KTP",
            ],
          ),
        ],
      ),
    );
  }

  Widget buildCard(
    BuildContext context,
    String title,
    List<String> syarat,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Berkas Persyaratan",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 10),

            ...syarat.map(
              (e) => Padding(
                padding: const EdgeInsets.only(
                  bottom: 4,
                ),
                child: Text("• $e"),
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          DataDiriScreen(
                        jenisLayanan: title,
                        syarat: syarat,
                      ),
                    ),
                  );
                },
                child: const Text(
                  "Antri",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}