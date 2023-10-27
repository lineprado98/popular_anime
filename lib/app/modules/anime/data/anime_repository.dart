import 'dart:convert';
import 'package:popular_anime/app/core/exceptions/my_exception.dart';
import 'package:popular_anime/app/core/services/http/i_http.dart';
import 'package:popular_anime/app/core/utils/app_keys.dart';
import 'package:popular_anime/app/core/services/cache/custom_response.dart';
import 'package:popular_anime/app/core/services/cache/i_cache.dart';
import 'package:popular_anime/app/modules/anime/data/i_anime_repository.dart';
import 'package:popular_anime/app/modules/anime/domain/entities/anime_entity.dart';
import 'package:popular_anime/app/modules/anime/domain/entities/anime_favorite_entity.dart';

class AnimeRepository implements IAnimeRepository {
  final IHttp dio;
  final ICache serviceBD;

  const AnimeRepository({required this.dio, required this.serviceBD});

  @override
  Future<(List<AnimeEntity>, MyException?)> getlistAnimes() async {
    final res =
        await dio.get(url: 'https://api.jikan.moe/v4/watch/promos/popular');
    List.from(res.body['data']).map((e) => AnimeEntity.fromJson(e)).toList();

    if (res.statusCode == 500) {
      return (<AnimeEntity>[], InternalError());
    }

    CustomResponse listFavorites = await serviceBD.get(key: AppKeys.favorites);
    var listAllAnimes = List.from(res.body['data'])
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
    CustomResponse listCurrent = await serviceBD.get(key: AppKeys.favorites);
    final List<String> list =
        listCurrent.data != null ? (listCurrent.data as List<String>) : [];

    final String animeparse =
        jsonEncode(AnimeFavoriteEntity.fromAnime(value).toMap());

    list.add(animeparse);

    await serviceBD.save(key: AppKeys.favorites, value: list);
  }

  @override
  Future<List<AnimeFavoriteEntity>> get() async {
    final response = await serviceBD.get(key: AppKeys.favorites);
    if (response.data != null) {
      return List.from(response.data)
          .map((item) => AnimeFavoriteEntity.fromJson(jsonDecode(item)))
          .toList();
    }

    return [];
  }

  @override
  Future<void> removeAnime({required AnimeEntity value}) async {
    final res = await serviceBD.get(key: AppKeys.favorites);
    final List<String> listRes = res.data;
    final parseAnime = jsonEncode(AnimeFavoriteEntity.fromAnime(value).toMap());
    listRes.removeWhere((element) => element == parseAnime);

    serviceBD.delete(key: AppKeys.favorites, value: listRes);
  }

  @override
  Future<void> removeFavorite({required AnimeFavoriteEntity value}) async {
    final res = await serviceBD.get(key: AppKeys.favorites);
    final List<String> listRes = res.data;
    final parseAnime = jsonEncode(value.toMap());
    listRes.removeWhere((element) => element == parseAnime);

    serviceBD.delete(key: AppKeys.favorites, value: listRes);
  }
}
