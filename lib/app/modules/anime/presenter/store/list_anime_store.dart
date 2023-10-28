import 'package:mobx/mobx.dart';
import 'package:popular_anime/app/core/exceptions/my_exception.dart';
import 'package:popular_anime/app/modules/anime/domain/entities/anime_entity.dart';
import 'package:popular_anime/app/modules/anime/domain/usecases/remove_anime.dart';
import 'package:popular_anime/app/modules/anime/domain/usecases/find_all_favorites.dart';
import 'package:popular_anime/app/modules/anime/domain/usecases/list_animes.dart';
import 'package:popular_anime/app/modules/anime/domain/usecases/save_favorite.dart';
part 'list_anime_store.g.dart';

class ListAnimeStore = _ListAnimeStoreBase with _$ListAnimeStore;

abstract class _ListAnimeStoreBase with Store {
  final ListAnimes usecase;
  final SaveFavorite saveCase;
  final RemoveAnime removeCase;
  final FindAllFavorites findCase;
  _ListAnimeStoreBase(
      {required this.usecase,
      required this.saveCase,
      required this.removeCase,
      required this.findCase});

  @observable
  bool isLoading = true;

  @action
  void seIsLoading(value) {
    isLoading = value;
  }

  @observable
  bool isError = false;
  void setIsError(value) {
    isError = value;
  }

  @observable
  List<AnimeEntity> response = [];

  @observable
  bool changeStatus = false;

  @action
  void setChangeStatus(bool value) {
    changeStatus = value;
  }

  @action
  void setResponse(List<AnimeEntity> value) {
    response.clear();
    response.addAll(value);
  }

  Future<void> getListAnimes() async {
    seIsLoading(true);
    final (anime, exception) = await usecase.getListAnimes();

    if (exception != null) {
      if (exception is InternalError) {
        setIsError(true);
      }
    }
    setResponse(anime);
    seIsLoading(false);
  }

  Future<void> save({required AnimeEntity value}) async {
    saveCase.save(value: value);
  }

  Future<void> remove({required AnimeEntity value}) async {
    removeCase.delete(value: value);
  }

  void setAsFavorite(int index, bool isFavorite) {
    setChangeStatus(isFavorite);
    response.elementAt(index).isFavorite = isFavorite;
  }
}
