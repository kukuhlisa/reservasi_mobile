import 'package:flutter/material.dart';

import 'upload_persyaratan_screen.dart';

class DataDiriPembayaranScreen extends StatefulWidget {
  final String jenisPembayaran;
  final List<String> syarat;

  const DataDiriPembayaranScreen({
    super.key,
    required this.jenisPembayaran,
    required this.syarat,
  });

  @override
  State<DataDiriPembayaranScreen> createState() =>
      _DataDiriPembayaranScreenState();
}

class _DataDiriPembayaranScreenState
    extends State<DataDiriPembayaranScreen> {

  final namaController =
      TextEditingController();

  final nimController =
      TextEditingController();

  final prodiController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Data Diri",
        ),
      ),

      body: Padding(
        padding:
            const EdgeInsets.all(20),

        child: Column(
          children: [

            TextField(
              controller:
                  namaController,
              decoration:
                  const InputDecoration(
                labelText: "Nama",
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller:
                  nimController,
              decoration:
                  const InputDecoration(
                labelText: "NIM",
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller:
                  prodiController,
              decoration:
                  const InputDecoration(
                labelText:
                    "Program Studi",
              ),
            ),

            const Spacer(),

            SizedBox(
              width:
                  double.infinity,

              child:
                  ElevatedButton(
                onPressed: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          UploadPersyaratanScreen(
                        jenisPembayaran:
                            widget
                                .jenisPembayaran,
                        syarat:
                            widget
                                .syarat,
                      ),
                    ),
                  );
                },

                child:
                    const Text(
                  "Lanjutkan",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}