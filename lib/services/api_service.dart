import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart'; 
import 'package:http_parser/http_parser.dart'; 
import 'package:shared_preferences/shared_preferences.dart'; 

class ApiService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'http://127.0.0.1:8000/api',
      headers: {
        'Accept': 'application/json',
      },
    ),
  );

  // ================= LOGIN =================
  Future<Map<String, dynamic>> login(
    String nim,
    String password,
    String role,
  ) async {
    try {
      final response = await dio.post(
        '/login',
        data: {
          'nim': nim,
          'password': password,
          'role': role,
        },
      );

      return response.data;
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ?? 'NIM atau password salah',
      );
    }
  }

  // ================= REGISTER =================
  Future<Map<String, dynamic>> register(
    String name,
    String nim,
    String email,
    String phone,
    String password,
    String role,
  ) async {
    try {
      final response = await dio.post(
        '/register',
        data: {
          'name': name,
          'nim': nim,
          'email': email,
          'phone': phone,
          'password': password,
          'role': role,
        },
      );

      return response.data;
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ?? 'Register gagal',
      );
    }
  }

  // ================= KIRIM OTP =================
  Future<Map<String, dynamic>> sendOtp(
    String phone,
  ) async {
    try {
      final response = await dio.post(
        '/forgot-password/send-otp',
        data: {
          'phone': phone,
        },
      );

      return response.data;
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ?? 'Gagal mengirim OTP',
      );
    }
  }

  // ================= VERIFIKASI OTP =================
  Future<Map<String, dynamic>> verifyOtp(
    String phone,
    String otp,
  ) async {
    try {
      final response = await dio.post(
        '/forgot-password/verify-otp',
        data: {
          'phone': phone,
          'otp': otp,
        },
      );

      return response.data;
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ?? 'OTP tidak valid',
      );
    }
  }

  // ================= RESET PASSWORD =================
  Future<Map<String, dynamic>> resetPassword(
    String phone,
    String otp,
    String password,
  ) async {
    try {
      final response = await dio.post(
        '/forgot-password/reset',
        data: {
          'phone': phone,
          'otp': otp,
          'password': password,
        },
      );

      return response.data;
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ?? 'Gagal reset password',
      );
    }
  }

  // ================= GET PROFILE =================
  Future<Map<String, dynamic>> getProfile(
    int userId,
  ) async {
    try {
      final response = await dio.get(
        '/profile/$userId',
      );

      final data = response.data;

      if (data['photo'] != null && data['photo'].toString().isNotEmpty) {
        String photoPath = data['photo'];
        
        if (!photoPath.startsWith('http')) {
          data['photo'] = 'http://127.0.0.1:8000/storage/' + photoPath;
        }
      }

      return data;
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ?? 'Gagal mengambil profil',
      );
    }
  }

  // ================= UPDATE PROFILE =================
  Future<Map<String, dynamic>> updateProfile(
    int userId,
    String name,
    String nim,
    String email,
    String phone,
  ) async {
    try {
      final response = await dio.put(
        '/profile/$userId',
        data: {
          'name': name,
          'nim': nim,
          'email': email,
          'phone': phone,
        },
      );

      return response.data;
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ?? 'Gagal memperbarui profil',
      );
    }
  }

  // ================= UPLOAD FOTO =================
  Future<void> uploadPhoto(
    int userId,
    XFile pickedFile,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token'); 

      final List<int> imageBytes = await pickedFile.readAsBytes();

      String extension = pickedFile.name.split('.').last.toLowerCase();
      String mimeType = (extension == 'png') ? 'image/png' : 'image/jpeg';

      FormData formData = FormData.fromMap({
        'photo': MultipartFile.fromBytes(
          imageBytes,
          filename: pickedFile.name, 
          contentType: MediaType.parse(mimeType),
        ),
      });

      final response = await dio.post(
        '/profile/$userId/photo',
        data: formData,
        options: Options(
          headers: {
            if (token != null) 'Authorization': 'Bearer $token',
          },
        ),
      );

      print("Respon Berhasil: ${response.data}");
    } on DioException catch (e) {
      print("Eror Detail Server: ${e.response?.data}");
      throw Exception(
        e.response?.data['message'] ?? 'Gagal menyimpan foto ke server',
      );
    }
  }

  // ================= SIMPAN PEMBAYARAN =================
  Future<Map<String, dynamic>> simpanPembayaran({
    required int userId,
    required String jenisPembayaran,
    required String metodePembayaran,
  }) async {
    try {
      final response = await dio.post(
        '/pembayaran',
        data: {
          'user_id': userId,
          'jenis_pembayaran': jenisPembayaran,
          'metode_pembayaran': metodePembayaran,
        },
      );

      return response.data;
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ?? 'Gagal menyimpan pembayaran',
      );
    }
  }

  // ================= SIMPAN ANTRIAN =================
  Future simpanAntrian({
    required String nama,
    required String nim,
    required String email,
    required String whatsapp,
    required String jenisLayanan,
    required String kategoriLayanan,
    required String metodePembayaran,
    required String waktuLayanan,
    required String nomorAntrian,
    required String status,
  }) async {
    return await dio.post(
      '/antrian',
      data: {
        'nama': nama,
        'nim': nim,
        'email': email,
        'whatsapp': whatsapp,
        'jenis_layanan': jenisLayanan,
        'kategori_layanan': kategoriLayanan,
        'metode_pembayaran': metodePembayaran,
        'waktu_layanan': waktuLayanan,
        'nomor_antrian': nomorAntrian,
        'status': status
      },
    );
  }

  // ================= GET RIWAYAT =================
  Future<List<dynamic>> getRiwayat(String nim) async {
    try {
      final response = await dio.get('/riwayat/$nim');
      return response.data;
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ?? 'Gagal mengambil riwayat'
      );
    }
  }

  // ================= GET DAFTAR ANTRIAN (PERBAIKAN MAP & LIST) =================
  Future<List<dynamic>> fetchAntrian() async {
    try {
      final response = await dio.get('/antrian');
      
      // Mengatasi error tipe data '_JsonMap' jika Laravel membungkus array-nya di dalam objek
      if (response.data is Map) {
        return response.data['data'] ?? []; 
      }
      
      return response.data; 
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ?? 'Gagal mengambil daftar antrean',
      );
    }
  }
} // Tanda kurung penutup class ApiService dipastikan aman di sini