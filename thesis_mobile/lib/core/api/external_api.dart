import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ExternalApiService {
  final Dio _dio = Dio();
  final String _url = dotenv.env['API_URL'] ?? '';

  Future<int> postLogData(Map<String, dynamic> data) async {
    try {
      Response post = await _dio.post(
        _url,
        options: Options(
            headers: {'key': dotenv.env['API_KEY']},
            contentType: 'application/json'),
        data: data,
      );
      return post.statusCode ?? -1;
    } catch (error, stacktrace) {
      throw Exception("[ERROR] $error \n [STACKTRACE] $stacktrace");
    }
  }
}
