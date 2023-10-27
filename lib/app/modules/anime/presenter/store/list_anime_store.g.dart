// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_anime_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ListAnimeStore on _ListAnimeStoreBase, Store {
  late final _$isLoadingAtom =
      Atom(name: '_ListAnimeStoreBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$isErrorAtom =
      Atom(name: '_ListAnimeStoreBase.isError', context: context);

  @override
  bool get isError {
    _$isErrorAtom.reportRead();
    return super.isError;
  }

  @override
  set isError(bool value) {
    _$isErrorAtom.reportWrite(value, super.isError, () {
      super.isError = value;
    });
  }

  late final _$responseAtom =
      Atom(name: '_ListAnimeStoreBase.response', context: context);

  @override
  List<AnimeEntity> get response {
    _$responseAtom.reportRead();
    return super.response;
  }

  @override
  set response(List<AnimeEntity> value) {
    _$responseAtom.reportWrite(value, super.response, () {
      super.response = value;
    });
  }

  late final _$changeStatusAtom =
      Atom(name: '_ListAnimeStoreBase.changeStatus', context: context);

  @override
  bool get changeStatus {
    _$changeStatusAtom.reportRead();
    return super.changeStatus;
  }

  @override
  set changeStatus(bool value) {
    _$changeStatusAtom.reportWrite(value, super.changeStatus, () {
      super.changeStatus = value;
    });
  }

  late final _$_ListAnimeStoreBaseActionController =
      ActionController(name: '_ListAnimeStoreBase', context: context);

  @override
  void seIsLoading(dynamic value) {
    final _$actionInfo = _$_ListAnimeStoreBaseActionController.startAction(
        name: '_ListAnimeStoreBase.seIsLoading');
    try {
      return super.seIsLoading(value);
    } finally {
      _$_ListAnimeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setChangeStatus(bool value) {
    final _$actionInfo = _$_ListAnimeStoreBaseActionController.startAction(
        name: '_ListAnimeStoreBase.setChangeStatus');
    try {
      return super.setChangeStatus(value);
    } finally {
      _$_ListAnimeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setResponse(List<AnimeEntity> value) {
    final _$actionInfo = _$_ListAnimeStoreBaseActionController.startAction(
        name: '_ListAnimeStoreBase.setResponse');
    try {
      return super.setResponse(value);
    } finally {
      _$_ListAnimeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
isError: ${isError},
response: ${response},
changeStatus: ${changeStatus}
    ''';
  }
}
