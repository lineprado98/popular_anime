import 'package:popular_anime/app/core/services/cache/custom_cache_response.dart';
import 'package:popular_anime/app/core/services/cache/i_cache_service.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class CacheServiceSharedPreferences implements ICacheService {
  CacheServiceSharedPreferences();

  @override
  Future<CustomCacheResponse> get({required String key}) async {
    try {
      final bd = await SharedPreferences.getInstance();
      final List<String>? res = bd.getStringList(key);
      return CustomCacheResponse(data: res, isError: false);
    } catch (e) {
      return CustomCacheResponse(data: null, isError: true);
    }
  }

  @override
  Future<CustomCacheResponse> save(
      {required String key, required List<String> value}) async {
    try {
      final bd = await SharedPreferences.getInstance();

      bd.setStringList(key, value);
      return CustomCacheResponse(data: null, isError: false);
    } catch (e) {
      return CustomCacheResponse(data: null, isError: true);
    }
  }

  @override
  Future<void> delete(
      {required String key, required List<String> value}) async {
    final bd = await SharedPreferences.getInstance();
    bd.setStringList(key, value);
  }
}
