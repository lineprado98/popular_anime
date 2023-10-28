import 'package:get_it/get_it.dart';
import 'package:popular_anime/app/core/services/http/http_dio_service.dart';
import 'package:popular_anime/app/core/services/cache/i_cache_service.dart';
import 'package:popular_anime/app/core/services/cache/cache_service_shared_preferences.dart';
import 'package:popular_anime/app/modules/anime/data/anime_repository.dart';
import 'package:popular_anime/app/modules/anime/data/i_anime_repository.dart';
import 'package:popular_anime/app/modules/anime/domain/usecases/remove_anime.dart';
import 'package:popular_anime/app/modules/anime/domain/usecases/find_all_favorites.dart';
import 'package:popular_anime/app/modules/anime/domain/usecases/list_animes.dart';
import 'package:popular_anime/app/modules/anime/domain/usecases/remove_favorite.dart';
import 'package:popular_anime/app/modules/anime/domain/usecases/save_favorite.dart';
import 'package:popular_anime/app/modules/anime/presenter/store/list_favorite_store.dart';
import '../../modules/anime/presenter/store/list_anime_store.dart';
import '../services/http/i_http_service.dart';

GetIt getIt = GetIt.instance;

class ServiceLocator {
  static void setup() {
    getIt.registerFactory<IHttpService>(() => HttpDioService());
    getIt.registerFactory<ICacheService>(() => CacheServiceSharedPreferences());

    getIt.registerFactory<IAnimeRepository>(() => AnimeRepository(
        http: getIt<IHttpService>(), cache: getIt<ICacheService>()));

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
