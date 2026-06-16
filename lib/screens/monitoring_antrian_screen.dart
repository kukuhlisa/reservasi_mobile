import 'package:flutter/material.dart';

class MonitoringAntrianScreen extends StatelessWidget {
  const MonitoringAntrianScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Monitoring Antrean",
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(20),
              ),

              child: const Column(
                children: [

                  Text(
                    "Nomor Yang Sedang Dipanggil",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    "A-005",
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView(
                children: const [

                  ListTile(
                    leading:
                        Icon(Icons.person),
                    title: Text("A-001"),
                    subtitle:
                        Text("Selesai"),
                  ),

                  ListTile(
                    leading:
                        Icon(Icons.person),
                    title: Text("A-002"),
                    subtitle:
                        Text("Selesai"),
                  ),

                  ListTile(
                    leading:
                        Icon(Icons.person),
                    title: Text("A-003"),
                    subtitle:
                        Text("Selesai"),
                  ),

                  ListTile(
                    leading:
                        Icon(Icons.person),
                    title: Text("A-004"),
                    subtitle:
                        Text("Dipanggil"),
                  ),

                  ListTile(
                    leading:
                        Icon(Icons.person),
                    title: Text("A-005"),
                    subtitle:
                        Text("Sedang Dilayani"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}