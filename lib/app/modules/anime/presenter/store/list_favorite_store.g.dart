// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_favorite_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ListFavoriteStore on _ListFavoriteStoreBase, Store {
  late final _$responseAtom =
      Atom(name: '_ListFavoriteStoreBase.response', context: context);

  @override
  List<AnimeFavoriteEntity> get response {
    _$responseAtom.reportRead();
    return super.response;
  }

  @override
  set response(List<AnimeFavoriteEntity> value) {
    _$responseAtom.reportWrite(value, super.response, () {
      super.response = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_ListFavoriteStoreBase.isLoading', context: context);

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
      Atom(name: '_ListFavoriteStoreBase.isError', context: context);

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

  late final _$_ListFavoriteStoreBaseActionController =
      ActionController(name: '_ListFavoriteStoreBase', context: context);

  @override
  void setResponse(dynamic value) {
    final _$actionInfo = _$_ListFavoriteStoreBaseActionController.startAction(
        name: '_ListFavoriteStoreBase.setResponse');
    try {
      return super.setResponse(value);
    } finally {
      _$_ListFavoriteStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsLoading(dynamic value) {
    final _$actionInfo = _$_ListFavoriteStoreBaseActionController.startAction(
        name: '_ListFavoriteStoreBase.setIsLoading');
    try {
      return super.setIsLoading(value);
    } finally {
      _$_ListFavoriteStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsError(dynamic value) {
    final _$actionInfo = _$_ListFavoriteStoreBaseActionController.startAction(
        name: '_ListFavoriteStoreBase.setIsError');
    try {
      return super.setIsError(value);
    } finally {
      _$_ListFavoriteStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
response: ${response},
isLoading: ${isLoading},
isError: ${isError}
    ''';
  }
}
