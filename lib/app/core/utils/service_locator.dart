import 'package:get_it/get_it.dart';
import 'package:popular_anime/app/core/services/http/http_dio_service.dart';
import '../services/http/i_http.dart';

GetIt getIt = GetIt.instance;

class ServiceLocator {
  static void setup() {
    getIt.registerFactory<IHttp>(() => HttpDioService());
  }
}
