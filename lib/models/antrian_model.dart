class Antrian {
  final String nomorAntrian;
  final String status;

  Antrian({required this.nomorAntrian, required this.status});

  // Mengubah JSON dari API menjadi objek Flutter
  factory Antrian.fromJson(Map<String, dynamic> json) {
    return Antrian(
      // Sesuaikan key string ini ('nomor_antrian'/'status') dengan field dari database/API kamu
      nomorAntrian: json['nomor_antrian'] ?? 'A000', 
      status: json['status'] ?? 'Menunggu',
    );
  }
}