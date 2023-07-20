import 'package:dio/dio.dart';

class DioHelper {

  static Dio? dio;

  static init() {
    dio = Dio(
        BaseOptions(
            baseUrl: 'https://student.valuxapps.com/api/',
            receiveDataWhenStatusError: true,
            headers: {
              'Content-Type': 'application/json',
            }
        )
    );
  }

  static Future<Response?> getData({
    required String url,
    required dynamic query
  }) async {
    init(); // Initialize the Dio instance
    return await dio?.get(
        url,
        queryParameters: query
    );
  }

  static Future<Response?> postData({
    required String url,
    dynamic query,
    required dynamic data,
    String lang = 'ar',
    String? token
  }) async {
    init(); // Initialize the Dio instance
    dio?.options.headers = {
      'lang': lang,
      'Authorization': token
    };
    return await dio?.post(
        url,
        data: data
    );
  }

}
