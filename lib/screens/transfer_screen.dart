import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class TransferScreen extends StatefulWidget {
  final String jenisPembayaran;

  const TransferScreen({
    super.key,
    required this.jenisPembayaran,
  });

  @override
  State<TransferScreen> createState() =>
      _TransferScreenState();
}

class _TransferScreenState
    extends State<TransferScreen> {

  String? namaFile;

  Future<void> uploadBukti() async {

    FilePickerResult? result =
        await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        namaFile =
            result.files.single.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:
          const Color(0xFFF5F6FA),

      appBar: AppBar(
        title: const Text(
          "Pembayaran Transfer",
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Text(
              widget.jenisPembayaran,
              style: const TextStyle(
                fontSize: 22,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Transfer ke rekening berikut",
              style: TextStyle(
                fontWeight:
                    FontWeight.bold,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 15),

            Card(
              shape:
                  RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(
                  15,
                ),
              ),

              child: const ListTile(
                leading: Icon(
                  Icons.account_balance,
                ),

                title: Text(
                  "Bank BRI",
                ),

                subtitle: Text(
                  "1234567890",
                ),
              ),
            ),

            const SizedBox(height: 20),

            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.upload_file,
                ),

                title: const Text(
                  "Bukti Transfer",
                ),

                subtitle: Text(
                  namaFile ??
                      "Belum upload",
                ),

                trailing: IconButton(
                  icon: const Icon(
                    Icons.add,
                  ),

                  onPressed:
                      uploadBukti,
                ),
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed:
                    namaFile == null
                        ? null
                        : () {

                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Bukti transfer berhasil dikirim dan menunggu verifikasi admin",
                                ),
                              ),
                            );
                          },

                child: const Text(
                  "Kirim Bukti Transfer",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}