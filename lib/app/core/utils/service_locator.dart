import 'package:get_it/get_it.dart';
import 'package:popular_anime/app/core/services/http/http_dio_service.dart';
import 'package:popular_anime/app/core/services/cache/i_cache.dart';
import 'package:popular_anime/app/core/services/cache/i_cache_service.dart';
import 'package:popular_anime/app/modules/anime/data/anime_repository.dart';
import 'package:popular_anime/app/modules/anime/data/i_anime_repository.dart';
import 'package:popular_anime/app/modules/anime/domain/use_cases/remove_anime.dart';
import 'package:popular_anime/app/modules/anime/domain/use_cases/find_all_favorites.dart';
import 'package:popular_anime/app/modules/anime/domain/use_cases/list_animes.dart';
import 'package:popular_anime/app/modules/anime/domain/use_cases/remove_favorite.dart';
import 'package:popular_anime/app/modules/anime/domain/use_cases/save_favorite.dart';
import 'package:popular_anime/app/modules/anime/presenter/store/list_favorite_store.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../modules/anime/presenter/store/list_anime_store.dart';
import '../services/http/i_http.dart';

GetIt getIt = GetIt.instance;

class ServiceLocator {
  static void setup() {
    //  getIt.registerFactory<SharedPreferences>(() => SharedPreferences.getInstance());

    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    getIt.registerFactory<IHttp>(() => HttpDioService());
    getIt.registerFactory<ICache>(() => ICacheService());

    getIt.registerFactory<IAnimeRepository>(
        () => AnimeRepository(dio: getIt<IHttp>(), serviceBD: getIt<ICache>()));

    getIt.registerFactory<SaveFavorite>(
        () => SaveFavorite(repository: getIt<IAnimeRepository>()));

    getIt.registerFactory<RemoveAnime>(
        () => RemoveAnime(repository: getIt<IAnimeRepository>()));
    getIt.registerFactory<RemoveFavorite>(
        () => RemoveFavorite(repository: getIt<IAnimeRepository>()));
    getIt.registerFactory<FindAllFavorites>(
        () => FindAllFavorites(repository: getIt<IAnimeRepository>()));

    getIt.registerFactory<ListAnimes>(
        () => ListAnimes(repository: getIt<IAnimeRepository>()));

    getIt.registerSingleton<ListAnimeStore>(ListAnimeStore(
        usecase: getIt<ListAnimes>(),
        saveCase: getIt<SaveFavorite>(),
        removeCase: getIt<RemoveAnime>(),
        findCase: getIt<FindAllFavorites>()));

    getIt.registerSingleton<ListFavoriteStore>(ListFavoriteStore(
        findCase: getIt<FindAllFavorites>(),
        removeFavorite: getIt<RemoveFavorite>()));
  }
}
