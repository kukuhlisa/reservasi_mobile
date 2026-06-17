import 'package:flutter/material.dart';

import 'upload_administrasi_screen.dart';

class DataDiriScreen extends StatefulWidget {

  final String jenisLayanan;
  final List<String> syarat;

  const DataDiriScreen({
    super.key,
    required this.jenisLayanan,
    required this.syarat,
  });

  @override
  State<DataDiriScreen> createState() =>
      _DataDiriScreenState();
}

class _DataDiriScreenState
    extends State<DataDiriScreen> {

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
        title:
            const Text("Data Diri"),
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
                labelText: "Program Studi",
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
                          UploadAdministrasiScreen(
                        jenisLayanan:
                            widget
                                .jenisLayanan,

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