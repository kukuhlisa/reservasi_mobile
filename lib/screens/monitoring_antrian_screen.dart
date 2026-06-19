import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MonitoringAntrianScreen
    extends StatefulWidget {

  const MonitoringAntrianScreen({
    super.key,
  });

  @override
  State<MonitoringAntrianScreen>
      createState() =>
          _MonitoringAntrianScreenState();
}

class _MonitoringAntrianScreenState
    extends State<MonitoringAntrianScreen> {

  String nomor = "-";
  String jenis = "-";
  String status = "-";
  String sesi = "-";
  String lokasi = "-";
  String jam = "-";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {

    final prefs =
        await SharedPreferences.getInstance();

    setState(() {
      nomor =
          prefs.getString(
            'nomor_antrian',
          ) ??
          '-';

      jenis =
          prefs.getString(
            'jenis_pelayanan',
          ) ??
          '-';

      status =
          prefs.getString(
            'status_antrian',
          ) ??
          '-';

      sesi =
          prefs.getString(
            'sesi',
          ) ??
          '-';

      lokasi =
          prefs.getString(
            'lokasi',
          ) ??
          '-';

      jam =
          prefs.getString(
            'jam_pelayanan',
          ) ??
          '-';
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:
          const Color(0xFFF5F5F5),

      appBar: AppBar(
        title: const Text(
          "Monitoring Antrean",
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(
                  20,
                ),
              ),

              child: Column(
                children: [

                  const Text(
                    "Nomor Antrian Anda",
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Text(
                    nomor,
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Card(
              child: ListTile(
                title: const Text(
                  "Jenis Pelayanan",
                ),
                subtitle: Text(jenis),
              ),
            ),

            Card(
              child: ListTile(
                title:
                    const Text("Sesi"),
                subtitle: Text(sesi),
              ),
            ),

            Card(
              child: ListTile(
                title:
                    const Text("Status"),
                subtitle: Text(status),
              ),
            ),

            Card(
              child: ListTile(
                title: const Text(
                  "Lokasi Pelayanan",
                ),

                subtitle: Text(
                  lokasi,
                ),
              ),
            ),

            Card(
              child: ListTile(
                title: const Text(
                  "Waktu Pelayanan",
                ),

                subtitle: Text(
                  jam,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}