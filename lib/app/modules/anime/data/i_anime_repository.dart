import 'package:popular_anime/app/core/exceptions/my_exception.dart';
import 'package:popular_anime/app/modules/anime/domain/entities/anime_entity.dart';
import 'package:popular_anime/app/modules/anime/domain/entities/anime_favorite_entity.dart';

abstract class IAnimeRepository {
  Future<(List<AnimeEntity>, MyException?)> getlistAnimes();

  Future<List<AnimeFavoriteEntity>> get();

  Future<void> save({required AnimeEntity value});

  Future<void> removeAnime({required AnimeEntity value});

  Future<void> removeFavorite({required AnimeFavoriteEntity value});
}
