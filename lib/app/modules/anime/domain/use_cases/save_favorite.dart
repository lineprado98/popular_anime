import 'package:popular_anime/app/modules/anime/data/i_anime_repository.dart';
import 'package:popular_anime/app/modules/anime/domain/entities/anime_entity.dart';

class SaveFavorite {
  final IAnimeRepository repository;
  const SaveFavorite({required this.repository});

  Future<void> save({required AnimeEntity value}) async {
    repository.save(value: value);
  }
}
