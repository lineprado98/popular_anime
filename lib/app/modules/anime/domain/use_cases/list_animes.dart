import 'package:popular_anime/app/modules/anime/data/i_anime_repository.dart';
import 'package:popular_anime/app/modules/anime/domain/entities/anime.dart';

class ListAnimes {
  final IAnimeRepository repository;
  ListAnimes({required this.repository});

  Future<List<Anime>> getListAnimes() async {
    return await repository.getlistAnimes();
  }
}
