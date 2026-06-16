import 'package:flutter/material.dart';

class KartuAntrianScreen extends StatelessWidget {
  final String nomorAntrian;
  final String jenisPelayanan;
  final String sesi;

  const KartuAntrianScreen({
    super.key,
    required this.nomorAntrian,
    required this.jenisPelayanan,
    required this.sesi,
  });

  String get jamSesi {
    if (sesi == "A") {
      return "08.00 - 12.00 WIB";
    } else {
      return "13.30 - 16.00 WIB";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),

      appBar: AppBar(
        centerTitle: true,
        title: const Text("Kartu Antrian"),
      ),

      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),

              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),

            child: Column(
              children: [

                const Text(
                  "NOMOR ANTRIAN ANDA",
                  style: TextStyle(
                    fontSize: 12,
                    letterSpacing: 2,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 16),

                Text(
                  nomorAntrian,
                  style: const TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),

                const SizedBox(height: 20),

                const Divider(),

                const SizedBox(height: 10),

                buildInfoRow(
                  "Jenis Pelayanan",
                  jenisPelayanan,
                ),

                const SizedBox(height: 15),

                buildInfoRow(
                  "Kategori",
                  jenisPelayanan,
                ),

                const SizedBox(height: 15),

                buildInfoRow(
                  "Waktu Pelayanan",
                  jamSesi,
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 55,

                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF0F172A),

                      foregroundColor:
                          Colors.white,

                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(
                          30,
                        ),
                      ),
                    ),

                    onPressed: () {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Fitur Monitoring Antrian segera hadir",
                          ),
                        ),
                      );
                    },

                    icon: const Icon(
                      Icons.arrow_forward,
                    ),

                    label: const Text(
                      "Monitoring Antrian",
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
        ),
      ),
    );
  }

  Widget buildInfoRow(
    String title,
    String value,
  ) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween,

      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),

        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,

            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}