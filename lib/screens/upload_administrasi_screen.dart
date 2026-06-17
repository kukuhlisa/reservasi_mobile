import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'pilih_sesi_screen.dart';

class UploadAdministrasiScreen extends StatefulWidget {
  final String jenisLayanan;
  final List<String> syarat;

  const UploadAdministrasiScreen({
    super.key,
    required this.jenisLayanan,
    required this.syarat,
  });

  @override
  State<UploadAdministrasiScreen> createState() =>
      _UploadAdministrasiScreenState();
}

class _UploadAdministrasiScreenState
    extends State<UploadAdministrasiScreen> {

  final Map<String, String> uploadedFiles = {};

  Future<void> pickFile(String syarat) async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        uploadedFiles[syarat] =
            result.files.single.name;
      });
    }
  }

  bool get isComplete =>
      uploadedFiles.length ==
      widget.syarat.length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF5F6FA),

      appBar: AppBar(
        title: Text(
          widget.jenisLayanan,
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            Expanded(
              child: ListView(
                children: [

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

                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        const Text(
                          "Upload Berkas Persyaratan",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        const SizedBox(
                          height: 16,
                        ),

                        ...widget.syarat.map(
                          (item) => Card(
                            child: ListTile(
                              title: Text(item),

                              subtitle: Text(
                                uploadedFiles[item] ??
                                    "Belum upload",
                              ),

                              trailing:
                                  IconButton(
                                icon:
                                    const Icon(
                                  Icons
                                      .upload_file,
                                ),

                                onPressed: () {
                                  pickFile(
                                    item,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton(
                onPressed: isComplete
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                PilihSesiScreen(
                              jenisPembayaran:
                                  widget
                                      .jenisLayanan,
                            ),
                          ),
                        );
                      }
                    : null,

                child: const Text(
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