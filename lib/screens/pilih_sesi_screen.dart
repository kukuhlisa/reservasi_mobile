import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'kartu_antrian_screen.dart';

class PilihSesiScreen extends StatefulWidget {
  final String jenisPembayaran;

  const PilihSesiScreen({
    super.key,
    required this.jenisPembayaran,
  });

  @override
  State<PilihSesiScreen> createState() =>
      _PilihSesiScreenState();
}

class _PilihSesiScreenState
    extends State<PilihSesiScreen> {

  String sesi = "A";
  String lokasi = "";

  Future<void> bukaMaps(String url) async {

  final Uri uri = Uri.parse(url);

  if (await canLaunchUrl(uri)) {
    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  }

}

  Future<void> ambilAntrian() async {

    /// sementara
    /// nanti diganti API Laravel

    String nomorAntrian;

    if (sesi == "A") {
      nomorAntrian = "A-001";
    } else {
      nomorAntrian = "B-001";
    }

    final prefs =
        await SharedPreferences.getInstance();

    await prefs.setString(
      'nomor_antrian',
      nomorAntrian,
    );

    await prefs.setString(
      'jenis_pelayanan',
      widget.jenisPembayaran,
    );

    await prefs.setString(
      'status_antrian',
      'Menunggu',
    );

    await prefs.setString(
      'sesi',
      sesi,
    );

    String jam;

    if (sesi == "A") {
      jam = "08.00 - 12.00 WIB";
    } else {
      jam = "13.30 - 16.00 WIB";
    }

    await prefs.setString(
      'jam_pelayanan',
      jam,
    );

    await prefs.setString(
      'lokasi',
      lokasi,
    );

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            KartuAntrianScreen(
          nomorAntrian: nomorAntrian,

          jenisPelayanan:
              widget.jenisPembayaran,

          sesi: sesi,

          lokasi: lokasi,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:
          const Color(0xFFF5F6FA),

      appBar: AppBar(
        title: const Text(
          "Pilih Sesi",
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            const Text(
              "Pilih Sesi Pelayanan",
              style: TextStyle(
                fontSize: 20,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Card(
              child: RadioListTile(
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
            ),

            Card(
              child: RadioListTile(
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
            ),

            const SizedBox(height: 25),

            const Text(
              "Pilih Lokasi Pelayanan",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Card(
              child: RadioListTile<String>(
                value: "Kampus Berkoh",
                groupValue: lokasi,

                title: const Text("Kampus Berkoh"),

                subtitle: const Text(
                  "Kampus Berkoh",
                ),

                secondary: IconButton(

                  icon: const Icon(
                    Icons.map,
                    color: Colors.blue,
                  ),

                  onPressed: () {

                    bukaMaps(
                      "https://maps.app.goo.gl/BbSdetHZcsRh82Qb8",
                    );

                  },

                ),

                onChanged: (value) {

                  setState(() {

                    lokasi = value!;

                  });

                },

              ),
            ),

            Card(
              child: RadioListTile<String>(
                value: "Kampus Soewatio",
                groupValue: lokasi,

                title: const Text("Kampus Soewatio"),

                subtitle: const Text(
                  "Kampus Soewatio",
                ),

                secondary: IconButton(

                  icon: const Icon(
                    Icons.map,
                    color: Colors.blue,
                  ),

                  onPressed: () {

                    bukaMaps(
                      "https://maps.app.goo.gl/XJKvDMX9DF63SGjaA",
                    );

                  },

                ),

                onChanged: (value) {

                  setState(() {

                    lokasi = value!;

                  });

                },

              ),
            ),

            const Spacer(),


            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton(
                onPressed:
                    ambilAntrian,

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