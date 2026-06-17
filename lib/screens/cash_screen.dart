import 'package:flutter/material.dart';

import 'pilih_sesi_screen.dart';

class CashScreen extends StatelessWidget {
  final String jenisPembayaran;

  const CashScreen({
    super.key,
    required this.jenisPembayaran,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),

      appBar: AppBar(
        title: const Text(
          "Pembayaran Cash",
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            Text(
              jenisPembayaran,
              style: const TextStyle(
                fontSize: 22,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Container(
              padding:
                  const EdgeInsets.all(16),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(
                  16,
                ),
              ),

              child: const Row(
                children: [
                  Icon(
                    Icons.payments,
                    size: 40,
                  ),

                  SizedBox(width: 12),

                  Expanded(
                    child: Text(
                      "Silakan lakukan pembayaran langsung di loket KAPUS sesuai sesi yang dipilih.",
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          PilihSesiScreen(
                        jenisPembayaran:
                            jenisPembayaran,
                      ),
                    ),
                  );
                },

                child: const Text(
                  "Pilih Sesi",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}