import 'package:popular_anime/app/modules/anime/domain/entities/anime.dart';

abstract class IAnimeRepository {
  Future<List<Anime>> getlistAnimes();
}
