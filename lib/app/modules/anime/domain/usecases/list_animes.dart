import 'package:popular_anime/app/core/exceptions/my_exception.dart';
import 'package:popular_anime/app/modules/anime/data/i_anime_repository.dart';
import 'package:popular_anime/app/modules/anime/domain/entities/anime_entity.dart';

class ListAnimes {
  final IAnimeRepository repository;

  const ListAnimes({required this.repository});

  Future<(List<AnimeEntity>, MyException?)> getListAnimes() async {
    return repository.getlistAnimes();
  }
}
