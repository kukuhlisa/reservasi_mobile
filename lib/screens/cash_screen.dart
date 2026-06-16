import 'package:flutter/material.dart';

import 'kartu_antrian_screen.dart';

class CashScreen extends StatefulWidget {
  final String jenisPembayaran;

  const CashScreen({
    super.key,
    required this.jenisPembayaran,
  });

  @override
  State<CashScreen> createState() =>
      _CashScreenState();
}

class _CashScreenState
    extends State<CashScreen> {

  String sesi = "A";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:
          const Color(0xFFF5F6FA),

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
              widget.jenisPembayaran,
              style: const TextStyle(
                fontSize: 20,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Pilih Sesi Pelayanan",
              style: TextStyle(
                fontSize: 18,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            RadioListTile(
              value: "A",
              groupValue: sesi,

              title: const Text(
                "Sesi A",
              ),

              subtitle: const Text(
                "08.00 - 12.00 WIB",
              ),

              onChanged: (value) {
                setState(() {
                  sesi = value!;
                });
              },
            ),

            RadioListTile(
              value: "B",
              groupValue: sesi,

              title: const Text(
                "Sesi B",
              ),

              subtitle: const Text(
                "13.30 - 16.00 WIB",
              ),

              onChanged: (value) {
                setState(() {
                  sesi = value!;
                });
              },
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: () {

                  String nomor;

                  if (sesi == "A") {
                    nomor = "A-001";
                  } else {
                    nomor = "B-001";
                  }

                  Navigator.push(
                    context,

                    MaterialPageRoute(
                      builder: (_) =>
                          KartuAntrianScreen(
                        nomorAntrian:
                            nomor,

                        jenisPelayanan:
                            widget
                                .jenisPembayaran,

                        sesi: sesi,
                      ),
                    ),
                  );
                },

                child: const Text(
                  "Ambil Antrian",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}