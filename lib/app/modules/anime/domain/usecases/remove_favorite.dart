import 'package:popular_anime/app/modules/anime/data/i_anime_repository.dart';
import 'package:popular_anime/app/modules/anime/domain/entities/anime_favorite_entity.dart';

class RemoveFavorite {
  final IAnimeRepository repository;

  const RemoveFavorite({required this.repository});

  Future<void> remove({required AnimeFavoriteEntity value}) async {
    repository.removeFavorite(value: value);
  }
}
