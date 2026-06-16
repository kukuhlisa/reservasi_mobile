import 'package:flutter/material.dart';

import 'kartu_antrian_screen.dart';

class PilihSesiScreen extends StatefulWidget {
  const PilihSesiScreen({super.key});

  @override
  State<PilihSesiScreen> createState() =>
      _PilihSesiScreenState();
}

class _PilihSesiScreenState
    extends State<PilihSesiScreen> {

  String sesi = "A";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pilih Sesi",
        ),
      ),

      body: Column(
        children: [

          RadioListTile(
            value: "A",
            groupValue: sesi,

            title: const Text(
              "Sesi A (08.00-12.00)",
            ),

            onChanged: (value) {
              setState(() {
                sesi = value!;
              });
            },
          ),

          RadioListTile(
            value: "B",
            groupValue: sesi,

            title: const Text(
              "Sesi B (13.30-16.00)",
            ),

            onChanged: (value) {
              setState(() {
                sesi = value!;
              });
            },
          ),

          ElevatedButton(
            onPressed: () {

              Navigator.push(
                context,

                MaterialPageRoute(
                  builder: (_) =>
                      KartuAntrianScreen(
                    sesi: sesi,
                  ),
                ),
              );
            },

            child: const Text(
              "Ambil Antrian",
            ),
          ),
        ],
      ),
    );
  }
}