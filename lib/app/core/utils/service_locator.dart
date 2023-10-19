import 'package:get_it/get_it.dart';
import 'package:popular_anime/app/core/services/http/http_dio_service.dart';
import 'package:popular_anime/app/modules/anime/data/anime_repository.dart';
import 'package:popular_anime/app/modules/anime/data/i_anime_repository.dart';
import 'package:popular_anime/app/modules/anime/domain/use_cases/list_animes.dart';
import '../../modules/anime/presenter/store/list_anime_store.dart';
import '../services/http/i_http.dart';

GetIt getIt = GetIt.instance;

class ServiceLocator {
  static void setup() {
    getIt.registerFactory<IHttp>(() => HttpDioService());

    getIt.registerFactory<IAnimeRepository>(
        () => AnimeRepository(dio: getIt<IHttp>()));

    getIt.registerFactory<ListAnimes>(
        () => ListAnimes(repository: getIt<IAnimeRepository>()));

    getIt.registerSingleton<ListAnimeStore>(
        ListAnimeStore(usecase: getIt<ListAnimes>()));
  }
}
