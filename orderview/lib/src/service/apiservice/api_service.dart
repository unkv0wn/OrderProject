import 'package:dio/dio.dart';

class DioService {
  static Dio getDioInstance() {
    Dio dio = Dio(BaseOptions(
      baseUrl: "http://localhost:3000",
      connectTimeout: Duration(),
      receiveTimeout: Duration(),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));
    return dio;
  }
}
