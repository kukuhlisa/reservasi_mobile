import 'package:flutter/material.dart';
import 'transfer_screen.dart';
import 'cash_screen.dart';

class MetodePembayaranScreen extends StatefulWidget {
  final String jenisPembayaran;

  const MetodePembayaranScreen({
    super.key,
    required this.jenisPembayaran,
  });

  @override
  State<MetodePembayaranScreen> createState() =>
      _MetodePembayaranScreenState();
}

class _MetodePembayaranScreenState
    extends State<MetodePembayaranScreen> {

  String? metode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),

      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Metode Pembayaran",
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(20),

                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  const Text(
                    "Jenis Layanan",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    widget.jenisPembayaran,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              "Pilih Metode Pembayaran",
              style: TextStyle(
                fontSize: 18,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(16),
              ),

              child: RadioListTile<String>(
                value: "Transfer",
                groupValue: metode,

                title: const Text(
                  "Transfer Bank",
                ),

                subtitle: const Text(
                  "Upload bukti transfer setelah pembayaran",
                ),

                secondary: const Icon(
                  Icons.account_balance,
                ),

                onChanged: (value) {
                  setState(() {
                    metode = value;
                  });
                },
              ),
            ),

            const SizedBox(height: 12),

            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(16),
              ),

              child: RadioListTile<String>(
                value: "Cash",
                groupValue: metode,

                title: const Text(
                  "Tunai (Cash)",
                ),

                subtitle: const Text(
                  "Bayar langsung di loket",
                ),

                secondary: const Icon(
                  Icons.payments,
                ),

                onChanged: (value) {
                  setState(() {
                    metode = value;
                  });
                },
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                      16,
                    ),
                  ),
                ),

                onPressed: () {

                  if (metode == null) {

                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Silakan pilih metode pembayaran terlebih dahulu",
                        ),
                      ),
                    );

                    return;
                  }

                  if (metode == "Transfer") {

                    Navigator.push(
                      context,

                      MaterialPageRoute(
                        builder: (_) =>
                            TransferScreen(
                          jenisPembayaran:
                              widget
                                  .jenisPembayaran,
                        ),
                      ),
                    );

                  } else {

                    Navigator.push(
                      context,

                      MaterialPageRoute(
                        builder: (_) =>
                            CashScreen(
                          jenisPembayaran:
                              widget
                                  .jenisPembayaran,
                        ),
                      ),
                    );

                  }
                },

                child: const Text(
                  "Lanjutkan",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}