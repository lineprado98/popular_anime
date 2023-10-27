import 'package:popular_anime/app/modules/anime/data/i_anime_repository.dart';
import 'package:popular_anime/app/modules/anime/domain/entities/anime_entity.dart';

class RemoveAnime {
  final IAnimeRepository repository;
  const RemoveAnime({required this.repository});

  Future<void> delete({required AnimeEntity value}) async {
    repository.removeAnime(value: value);
  }
}
