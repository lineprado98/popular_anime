import 'package:popular_anime/app/core/services/http/custom_http_response.dart';

abstract class IHttpService {
  Future<CustomHttpResponse> get({required String url});
}
