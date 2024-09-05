// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ImageStore on ImageStoreBase, Store {
  late final _$pageAtom = Atom(name: 'ImageStoreBase.page', context: context);

  @override
  int get page {
    _$pageAtom.reportRead();
    return super.page;
  }

  @override
  set page(int value) {
    _$pageAtom.reportWrite(value, super.page, () {
      super.page = value;
    });
  }

  late final _$searchPageAtom =
      Atom(name: 'ImageStoreBase.searchPage', context: context);

  @override
  int get searchPage {
    _$searchPageAtom.reportRead();
    return super.searchPage;
  }

  @override
  set searchPage(int value) {
    _$searchPageAtom.reportWrite(value, super.searchPage, () {
      super.searchPage = value;
    });
  }

  late final _$searchQueryAtom =
      Atom(name: 'ImageStoreBase.searchQuery', context: context);

  @override
  String get searchQuery {
    _$searchQueryAtom.reportRead();
    return super.searchQuery;
  }

  @override
  set searchQuery(String value) {
    _$searchQueryAtom.reportWrite(value, super.searchQuery, () {
      super.searchQuery = value;
    });
  }

  late final _$imagesAtom =
      Atom(name: 'ImageStoreBase.images', context: context);

  @override
  ObservableList<ImageModel> get images {
    _$imagesAtom.reportRead();
    return super.images;
  }

  @override
  set images(ObservableList<ImageModel> value) {
    _$imagesAtom.reportWrite(value, super.images, () {
      super.images = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'ImageStoreBase.isLoading', context: context);

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

  late final _$isDownloadingAtom =
      Atom(name: 'ImageStoreBase.isDownloading', context: context);

  @override
  bool get isDownloading {
    _$isDownloadingAtom.reportRead();
    return super.isDownloading;
  }

  @override
  set isDownloading(bool value) {
    _$isDownloadingAtom.reportWrite(value, super.isDownloading, () {
      super.isDownloading = value;
    });
  }

  late final _$storeInitializeAsyncAction =
      AsyncAction('ImageStoreBase.storeInitialize', context: context);

  @override
  Future<void> storeInitialize() {
    return _$storeInitializeAsyncAction.run(() => super.storeInitialize());
  }

  late final _$getPermissionAsyncAction =
      AsyncAction('ImageStoreBase.getPermission', context: context);

  @override
  Future<void> getPermission() {
    return _$getPermissionAsyncAction.run(() => super.getPermission());
  }

  late final _$fetchPhotosAsyncAction =
      AsyncAction('ImageStoreBase.fetchPhotos', context: context);

  @override
  Future<List<ImageModel>> fetchPhotos(int page) {
    return _$fetchPhotosAsyncAction.run(() => super.fetchPhotos(page));
  }

  late final _$searchPhotosAsyncAction =
      AsyncAction('ImageStoreBase.searchPhotos', context: context);

  @override
  Future<List<ImageModel>> searchPhotos(String query, int searchPage) {
    return _$searchPhotosAsyncAction
        .run(() => super.searchPhotos(query, searchPage));
  }

  late final _$downloadImageAsyncAction =
      AsyncAction('ImageStoreBase.downloadImage', context: context);

  @override
  Future<void> downloadImage(String url) {
    return _$downloadImageAsyncAction.run(() => super.downloadImage(url));
  }

  late final _$ImageStoreBaseActionController =
      ActionController(name: 'ImageStoreBase', context: context);

  @override
  void dispose() {
    final _$actionInfo = _$ImageStoreBaseActionController.startAction(
        name: 'ImageStoreBase.dispose');
    try {
      return super.dispose();
    } finally {
      _$ImageStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearImagesList() {
    final _$actionInfo = _$ImageStoreBaseActionController.startAction(
        name: 'ImageStoreBase.clearImagesList');
    try {
      return super.clearImagesList();
    } finally {
      _$ImageStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onSearchChanged() {
    final _$actionInfo = _$ImageStoreBaseActionController.startAction(
        name: 'ImageStoreBase.onSearchChanged');
    try {
      return super.onSearchChanged();
    } finally {
      _$ImageStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void scrollListener() {
    final _$actionInfo = _$ImageStoreBaseActionController.startAction(
        name: 'ImageStoreBase.scrollListener');
    try {
      return super.scrollListener();
    } finally {
      _$ImageStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
page: ${page},
searchPage: ${searchPage},
searchQuery: ${searchQuery},
images: ${images},
isLoading: ${isLoading},
isDownloading: ${isDownloading}
    ''';
  }
}
