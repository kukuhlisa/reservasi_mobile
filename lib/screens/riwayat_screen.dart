import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/api_service.dart';

class RiwayatScreen extends StatefulWidget {
  const RiwayatScreen({super.key});

  @override
  State<RiwayatScreen> createState() =>
      _RiwayatScreenState();
}

class _RiwayatScreenState
    extends State<RiwayatScreen> {

  final ApiService api = ApiService();

  List<dynamic> riwayat = [];

  bool loading = true;

  String keyword = "";



  @override
  void initState() {
    super.initState();

    getRiwayat();
  }



  Future<void> getRiwayat() async {

    try {

      final prefs =
          await SharedPreferences.getInstance();

      String nim =
          prefs.getString('nim') ?? "";



      final data =
          await api.getRiwayat(nim);



      setState(() {

        riwayat = data;

        loading = false;

      });


    } catch (e) {

      setState(() {

        loading = false;

      });

    }

  }





  @override
  Widget build(BuildContext context) {

    List<dynamic> filtered =

        riwayat.where((item) {

      return item['jenis_layanan']

          .toString()

          .toLowerCase()

          .contains(

            keyword.toLowerCase()

          );

    }).toList();



    return Scaffold(

      backgroundColor:
          const Color(0xFFF5F5F5),

      appBar: AppBar(

        title: const Text(

          "Riwayat Antrian",

        ),

      ),

      body: Column(

        children: [

          Padding(

            padding:
                const EdgeInsets.all(16),

            child: TextField(

              decoration:

                  InputDecoration(

                hintText:
                    "Cari layanan",

                prefixIcon:

                    const Icon(

                  Icons.search,

                ),

                border:

                    OutlineInputBorder(

                  borderRadius:

                      BorderRadius.circular(

                    25,

                  ),

                ),

              ),

              onChanged: (value) {

                setState(() {

                  keyword = value;

                });

              },

            ),

          ),



          Expanded(

            child: loading


                ? const Center(

                    child:

                        CircularProgressIndicator(),

                  )


                : filtered.isEmpty


                    ? const Center(

                        child: Text(

                          "Belum ada riwayat",

                        ),

                      )


                    : ListView.builder(

                        itemCount:

                            filtered.length,



                        itemBuilder:

                            (context,index) {


                          var item =

                              filtered[index];



                          return Card(

                            margin:

                                const EdgeInsets.symmetric(

                              horizontal: 16,

                              vertical: 8,

                            ),


                            shape:

                                RoundedRectangleBorder(

                              borderRadius:

                                  BorderRadius.circular(

                                20,

                              ),

                            ),


                            child: Padding(

                              padding:

                                  const EdgeInsets.all(

                                16,

                              ),

                              child: Column(

                                crossAxisAlignment:

                                    CrossAxisAlignment.start,

                                children: [

                                  Text(

                                    item['jenis_layanan'],

                                    style:

                                        const TextStyle(

                                      fontSize: 18,

                                      fontWeight:

                                          FontWeight.bold,

                                    ),

                                  ),

                                  const SizedBox(

                                    height: 10,

                                  ),

                                  Text(

                                    "Nomor Antrian : "

                                    "${item['nomor_antrian'] ?? '-'}",

                                  ),

                                  Text(

                                    "Status : "

                                    "${item['status']}",

                                  ),

                                  Text(

                                    "Metode : "

                                    "${item['metode_pembayaran'] ?? '-'}",

                                  ),

                                  Text(

                                    "Waktu : "

                                    "${item['waktu_layanan'] ?? '-'}",

                                  ),

                                  Text(

                                    "Tanggal : "

                                    "${item['tanggal_antrian']}",

                                  ),

                                ],

                              ),

                            ),

                          );

                        },

                      ),

          ),

        ],

      ),

    );

  }

}
