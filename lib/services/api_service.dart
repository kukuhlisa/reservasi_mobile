import 'package:dio/dio.dart';

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
        e.response?.data['message'] ??
            'NIM atau password salah',
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
        e.response?.data['message'] ??
            'Register gagal',
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
        e.response?.data['message'] ??
            'Gagal mengirim OTP',
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
        e.response?.data['message'] ??
            'OTP tidak valid',
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
      e.response?.data['message'] ??
          'Gagal reset password',
    );
  }
}
}