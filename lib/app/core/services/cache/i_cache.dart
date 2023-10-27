import 'package:popular_anime/app/core/services/cache/custom_response.dart';

abstract class ICache {
  Future<CustomResponse> save(
      {required String key, required List<String> value});

  Future<CustomResponse> get({required String key});

  Future<void> delete({required String key, required List<String> value});
}
