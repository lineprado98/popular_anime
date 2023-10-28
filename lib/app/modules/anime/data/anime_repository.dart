import 'dart:convert';
import 'package:popular_anime/app/core/exceptions/my_exception.dart';
import 'package:popular_anime/app/core/services/http/i_http_service.dart';
import 'package:popular_anime/app/core/utils/app_enviroments.dart';
import 'package:popular_anime/app/core/utils/app_keys.dart';
import 'package:popular_anime/app/core/services/cache/custom_cache_response.dart';
import 'package:popular_anime/app/core/services/cache/i_cache_service.dart';
import 'package:popular_anime/app/modules/anime/data/i_anime_repository.dart';
import 'package:popular_anime/app/modules/anime/domain/entities/anime_entity.dart';
import 'package:popular_anime/app/modules/anime/domain/entities/anime_favorite_entity.dart';

class AnimeRepository implements IAnimeRepository {
  final IHttpService http;
  final ICacheService cache;

  const AnimeRepository({required this.http, required this.cache});

  @override
  Future<(List<AnimeEntity>, MyException?)> getlistAnimes() async {
    final response = await http.get(url: AppEnviroments.baseUrl);
    List.from(response.body['data'])
        .map((e) => AnimeEntity.fromJson(e))
        .toList();

    if (response.statusCode == 500) {
      return (<AnimeEntity>[], InternalError());
    }

    CustomCacheResponse listFavorites = await cache.get(key: AppKeys.favorites);
    var listAllAnimes = List.from(response.body['data'])
        .map((e) => AnimeEntity.fromJson(e))
        .toList();

    if (listFavorites.data != null) {
      for (var i in listFavorites.data) {
        var item = AnimeFavoriteEntity.fromJson(jsonDecode(i));
        AnimeEntity animeExistente = listAllAnimes.firstWhere(
            (i) => i.title == item.name,
            orElse: () => AnimeEntity(title: '', image: '', isFavorite: false));

        if (animeExistente.title.isNotEmpty) {
          animeExistente.isFavorite = true;
        }
      }
    }

    return (listAllAnimes, null);
  }

  @override
  Future<void> save({required AnimeEntity value}) async {
    CustomCacheResponse listCurrent = await cache.get(key: AppKeys.favorites);
    final List<String> list =
        listCurrent.data != null ? (listCurrent.data as List<String>) : [];

    final String animeparse =
        jsonEncode(AnimeFavoriteEntity.fromAnime(value).toMap());

    list.add(animeparse);

    await cache.save(key: AppKeys.favorites, value: list);
  }

  @override
  Future<List<AnimeFavoriteEntity>> get() async {
    final response = await cache.get(key: AppKeys.favorites);
    final List<String> listFavorite = response.data;
    if (listFavorite.isNotEmpty) {
      return List.from(response.data)
          .map((item) => AnimeFavoriteEntity.fromJson(jsonDecode(item)))
          .toList();
    }

    return [];
  }

  @override
  Future<void> removeAnime({required AnimeEntity value}) async {
    final res = await cache.get(key: AppKeys.favorites);
    final List<String> listRes = res.data;
    final parseAnime = jsonEncode(AnimeFavoriteEntity.fromAnime(value).toMap());
    listRes.removeWhere((element) => element == parseAnime);

    cache.delete(key: AppKeys.favorites, value: listRes);
  }

  @override
  Future<void> removeFavorite({required AnimeFavoriteEntity value}) async {
    final res = await cache.get(key: AppKeys.favorites);
    final List<String> listRes = res.data;
    final parseAnime = jsonEncode(value.toMap());
    listRes.removeWhere((element) => element == parseAnime);

    cache.delete(key: AppKeys.favorites, value: listRes);
  }
}
