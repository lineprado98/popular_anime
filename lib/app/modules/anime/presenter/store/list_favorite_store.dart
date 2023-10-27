import 'package:mobx/mobx.dart';
import 'package:popular_anime/app/modules/anime/domain/entities/anime_favorite_entity.dart';
import 'package:popular_anime/app/modules/anime/domain/use_cases/find_all_favorites.dart';
import 'package:popular_anime/app/modules/anime/domain/use_cases/remove_favorite.dart';
part 'list_favorite_store.g.dart';

class ListFavoriteStore = _ListFavoriteStoreBase with _$ListFavoriteStore;

abstract class _ListFavoriteStoreBase with Store {
  final FindAllFavorites findCase;
  final RemoveFavorite removeFavorite;
  _ListFavoriteStoreBase(
      {required this.findCase, required this.removeFavorite});

  @observable
  List<AnimeFavoriteEntity> response = [];

  @action
  void setResponse(value) {
    response = value;
  }

  @observable
  bool isLoading = false;
  @action
  void setIsLoading(value) {
    isLoading = value;
  }

  @observable
  bool isError = false;
  @action
  void setIsError(value) {
    isError = value;
  }

  Future<void> getListFavorites() async {
    final res = await findCase.getAll();
    res != null ? setResponse(res) : [];
  }

  Future<void> remove(AnimeFavoriteEntity value) async {
    await removeFavorite.remove(value: value);
  }
}
