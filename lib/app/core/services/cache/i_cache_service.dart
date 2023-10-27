import 'package:popular_anime/app/core/services/cache/custom_response.dart';
import 'package:popular_anime/app/core/services/cache/i_cache.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

class ICacheService implements ICache {
  @override
  Future<CustomResponse> get({required String key}) async {
    try {
      final bd = await _prefs;
      final List<String>? res = bd.getStringList(key);
      return CustomResponse(data: res, isError: false);
    } catch (e) {
      return CustomResponse(data: null, isError: true);
    }
  }

  @override
  Future<CustomResponse> save(
      {required String key, required List<String> value}) async {
    try {
      final bd = await _prefs;
      bd.setStringList(key, value);
      return CustomResponse(data: null, isError: false);
    } catch (e) {
      return CustomResponse(data: null, isError: true);
    }
  }

  @override
  Future<void> delete(
      {required String key, required List<String> value}) async {
    final bd = await _prefs;
    print(value);
    bd.setStringList(key, value);
  }
}
