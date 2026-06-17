import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart'; // Diperlukan untuk objek XFile

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

      return response.data;
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

  // ================= UPLOAD FOTO (FIXED WEB & MOBILE) =================
  Future<void> uploadPhoto(
    int userId,
    XFile pickedFile, // Perbaikan: Menggunakan objek XFile, bukan String path
  ) async {
    try {
      // Membaca file gambar menjadi bentuk biner bytes (Aman untuk Flutter Web)
      final List<int> imageBytes = await pickedFile.readAsBytes();

      FormData formData = FormData.fromMap({
        'photo': MultipartFile.fromBytes(
          imageBytes,
          filename: pickedFile.name, // Mengambil nama file asli beserta ekstensi
        ),
      });

      final response = await dio.post(
        '/profile/$userId/photo',
        data: formData,
      );

      print("Respon Berhasil: ${response.data}");
    } on DioException catch (e) {
      print("Eror Detail Server: ${e.response?.data}");
      rethrow;
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
}