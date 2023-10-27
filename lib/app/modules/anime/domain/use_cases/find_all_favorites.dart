import 'package:popular_anime/app/modules/anime/data/i_anime_repository.dart';
import 'package:popular_anime/app/modules/anime/domain/entities/anime_favorite_entity.dart';

class FindAllFavorites {
  final IAnimeRepository repository;
  const FindAllFavorites({required this.repository});

  Future<List<AnimeFavoriteEntity>> getAll() async {
    return await repository.get();
  }
}
