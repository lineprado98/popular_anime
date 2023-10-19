import 'dart:developer';
import 'package:mobx/mobx.dart';
import 'package:popular_anime/app/modules/anime/domain/entities/anime.dart';
import 'package:popular_anime/app/modules/anime/domain/use_cases/list_animes.dart';
part 'list_anime_store.g.dart';

class ListAnimeStore = _ListAnimeStoreBase with _$ListAnimeStore;

abstract class _ListAnimeStoreBase with Store {
  final ListAnimes usecase;
  _ListAnimeStoreBase({required this.usecase});

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
  List<Anime> response = [];

  @action
  void setResponse(List<Anime> value) {
    response = value;
  }

  Future<void> getListAnimes() async {
    final List<Anime> res = await usecase.getListAnimes();
    print(inspect(res));
    setResponse(res);
    seIsLoading(false);
  }
}
