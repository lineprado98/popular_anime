import 'package:popular_anime/app/modules/anime/data/i_anime_repository.dart';
import 'package:popular_anime/app/modules/anime/domain/entities/anime.dart';

import '../../../core/services/http/i_http.dart';

class AnimeRepository implements IAnimeRepository {
  final IHttp dio;

  const AnimeRepository({required this.dio});

  @override
  Future<List<Anime>> getlistAnimes() async {
    try {
      final res =
          await dio.get(url: 'https://api.jikan.moe/v4/watch/promos/popular');
      return List.from(res.body['data']).map((e) => Anime.fromJson(e)).toList();
    } catch (e) {
      throw UnimplementedError();
    }
  }
}
