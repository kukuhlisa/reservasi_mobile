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
}