import 'package:popular_anime/app/core/services/cache/custom_cache_response.dart';

abstract class ICacheService {
  Future<CustomCacheResponse> save(
      {required String key, required List<String> value});

  Future<CustomCacheResponse> get({required String key});

  Future<void> delete({required String key, required List<String> value});
}
