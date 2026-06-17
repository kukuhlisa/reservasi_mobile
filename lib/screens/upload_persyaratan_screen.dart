import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'metode_pembayaran_screen.dart';

class UploadPersyaratanScreen extends StatefulWidget {
  final String jenisPembayaran;
  final List<String> syarat;

  const UploadPersyaratanScreen({
    super.key,
    required this.jenisPembayaran,
    required this.syarat,
  });

  @override
  State<UploadPersyaratanScreen> createState() =>
      _UploadPersyaratanScreenState();
}

class _UploadPersyaratanScreenState
    extends State<UploadPersyaratanScreen> {

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
      uploadedFiles.length == widget.syarat.length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.jenisPembayaran),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            ...widget.syarat.map(
              (item) => Card(
                child: ListTile(
                  title: Text(item),

                  subtitle: Text(
                    uploadedFiles[item] ??
                        "Belum upload",
                  ),

                  trailing: IconButton(
                    icon: const Icon(
                      Icons.upload_file,
                    ),

                    onPressed: () {
                      pickFile(item);
                    },
                  ),
                ),
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
              onPressed: isComplete
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              MetodePembayaranScreen(
                                jenisPembayaran:
                                    widget.jenisPembayaran,
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