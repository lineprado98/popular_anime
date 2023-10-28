import 'package:dio/dio.dart';
import 'package:popular_anime/app/core/services/http/custom_http_response.dart';
import 'i_http_service.dart';

class HttpDioService implements IHttpService {
  final dio = Dio();

  @override
  Future<CustomHttpResponse> get({required String url}) async {
    try {
      final res = await dio.get(url);
      return CustomHttpResponse.fromSuccessDio(res);
    } catch (e) {
      e as DioException;
      return CustomHttpResponse.fromErrorDio(e);
    }
  }
}
