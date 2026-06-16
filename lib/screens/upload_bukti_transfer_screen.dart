import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class UploadBuktiTransferScreen
    extends StatefulWidget {

  const UploadBuktiTransferScreen({
    super.key,
  });

  @override
  State<UploadBuktiTransferScreen>
      createState() =>
          _UploadBuktiTransferScreenState();
}

class _UploadBuktiTransferScreenState
    extends State<UploadBuktiTransferScreen> {

  String? fileName;

  Future<void> upload() async {

    FilePickerResult? result =
        await FilePicker.platform.pickFiles();

    if (result != null) {

      setState(() {
        fileName =
            result.files.single.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Bukti Transfer",
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            Text(
              fileName ??
                  "Belum upload bukti",
            ),

            const SizedBox(
              height: 20,
            ),

            ElevatedButton(
              onPressed: upload,
              child: const Text(
                "Upload Bukti",
              ),
            ),

            const Spacer(),

            ElevatedButton(
              onPressed: fileName == null
                  ? null
                  : () {

                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Menunggu verifikasi admin",
                          ),
                        ),
                      );
                    },

              child: const Text(
                "Kirim",
              ),
            ),
          ],
        ),
      ),
    );
  }
}