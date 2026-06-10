import 'package:flutter/material.dart';
import 'riwayat_screen.dart';
import 'tambah_screen.dart';
import 'notifikasi_screen.dart';
import 'profil_screen.dart';

class DashboardScreen extends StatefulWidget {
  final String name;

  const DashboardScreen({
    super.key,
    required this.name,
  });

  @override
  State<DashboardScreen> createState() =>
      _DashboardScreenState();
}

class _DashboardScreenState
    extends State<DashboardScreen> {
  int selectedIndex = 0;

  void menuClicked(String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("$title dibuka"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFF2F2F2,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.all(16),

          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(
                    30,
                  ),
                ),

                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,
                      children: [
                        const Text(
                          "ANTRE.in",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor:
                              Colors.grey.shade200,
                          child: const Icon(
                            Icons.person,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,
                      children: [
                        const Text(
                          "Beranda",
                          style: TextStyle(
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        Column(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .end,
                          children: [
                            Text(
                              "Halo, ${widget.name}",
                              style:
                                  const TextStyle(
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                            const Text(
                              "Mahasiswa",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    TextField(
                      decoration:
                          InputDecoration(
                        hintText: "Cari",

                        prefixIcon:
                            const Icon(
                          Icons.search,
                        ),

                        filled: true,
                        fillColor:
                            Colors.grey.shade100,

                        border:
                            OutlineInputBorder(
                          borderRadius:
                              BorderRadius
                                  .circular(
                            30,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    Container(
                      padding:
                          const EdgeInsets.all(
                        16,
                      ),

                      decoration:
                          BoxDecoration(
                        color:
                            Colors.grey.shade200,
                        borderRadius:
                            BorderRadius
                                .circular(
                          20,
                        ),
                      ),

                      child: Column(
                        children: [
                          const Icon(
                            Icons.calendar_month,
                            size: 40,
                          ),

                          const SizedBox(
                            height: 8,
                          ),

                          const Text(
                            "Senin",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          const Text(
                            "27 April 2026",
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          ElevatedButton(
                            onPressed: () {
                              menuClicked(
                                "Ambil Antrian",
                              );
                            },
                            child: const Text(
                              "Ambil Antrian",
                            ),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    buildMenuCard(
                      "Pembayaran",
                      Icons.payments,
                    ),

                    buildMenuCard(
                      "Administrasi",
                      Icons.description,
                    ),

                    buildInfoCard(),

                    buildQueueCard(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,

        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });

          switch (index) {
            case 0:
              break;

            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const RiwayatScreen(),
                ),
              );
              break;

            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const TambahScreen(),
                ),
              );
              break;

            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const NotifikasiScreen(),
                ),
              );
              break;

            case 4:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ProfilScreen(),
                ),
              );
              break;
          }
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Riwayat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: 'Tambah',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notif',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  Widget buildMenuCard(
    String title,
    IconData icon,
  ) {
    return Card(
      margin:
          const EdgeInsets.only(bottom: 12),

      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(20),
      ),

      child: ListTile(
        leading: Icon(icon),
        title: Text(title),

        subtitle: Text(
          "Klik untuk membuka menu $title",
        ),

        trailing: const Icon(
          Icons.arrow_forward_ios,
        ),

        onTap: () {
          menuClicked(title);
        },
      ),
    );
  }

  Widget buildInfoCard() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(20),
      ),

      child: Padding(
        padding:
            const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: const [
            Text(
              "Info Layanan",
              style: TextStyle(
                fontWeight:
                    FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text("Senin - Jumat"),
            Text("08:00 - 16:00"),
            Divider(),
            Text("Sabtu"),
            Text("08:00 - 12:00"),
          ],
        ),
      ),
    );
  }

  Widget buildQueueCard() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(20),
      ),

      child: Padding(
        padding:
            const EdgeInsets.all(16),

        child: Column(
          children: List.generate(
            6,
            (index) => ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.person),
              ),
              title: Text(
                "User ${index + 1}",
              ),
              subtitle: const Text(
                "Sedang Menunggu",
              ),
            ),
          ),
        ),
      ),
    );
  }
}