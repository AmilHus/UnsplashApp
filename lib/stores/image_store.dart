import 'dart:async';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';
import '../models/image_model.dart';
import '../services/unsplash_service.dart';
import '../services/download_service.dart';

part 'image_store.g.dart';

class ImageStore = ImageStoreBase with _$ImageStore;

abstract class ImageStoreBase with Store {
  UnsplashService unsplashService = UnsplashService();
  DownloadService downloadService = DownloadService(dio: Dio());
  ScrollController scrollController = ScrollController();
  TextEditingController textEditingController = TextEditingController();

  @observable
  int page = 1;

  @observable
  int searchPage = 1;

  @observable
  String searchQuery = '';

  @observable
  ObservableList<ImageModel> images = ObservableList<ImageModel>();

  @observable
  bool isLoading = false;

  @observable
  bool isDownloading = false;

  @action
  Future<void> storeInitialize() async {
    isLoading = true;
    getPermission();
    unsplashService = UnsplashService();
    downloadService = DownloadService(dio: Dio());
    scrollController = ScrollController()..addListener(scrollListener);
    await fetchPhotos(page);
    isLoading = false;
  }
  
  @action
  Future<void> getPermission() async {
    await Permission.storage.request();
    await Permission.manageExternalStorage.request();
  }

  @action
  void dispose() {
    scrollController.removeListener(scrollListener);
    downloadService.progressController.close();
  }

  @action
  Future<List<ImageModel>> fetchPhotos(int page) async {
    isLoading = true;
    try {
      final photos = await unsplashService.fetchDataFromApi(page);
      images.addAll(photos);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      isLoading = false;
    }
    return [];
  }

  @action
  void clearImagesList(){
    images.clear();
    page = 1;
    searchPage = 1;
  }

  @action
  Future<List<ImageModel>> searchPhotos(String query, int searchPage) async {
    isLoading = true;
    try {
      if (query.isEmpty) {
        fetchPhotos(1);
      }
      else{
      final photos = await unsplashService.searchDataFromApi(query, searchPage);
      images.addAll(photos);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      isLoading = false;
    }
    return images;
  } 
  
  @action
   void onSearchChanged() {
        clearImagesList();
        searchPhotos(textEditingController.text,searchPage);
  }

  @action
  Future<void> downloadImage(String url) async {
    isDownloading = true;
    Directory? directory = await getDownloadsDirectory();
    String path = directory!.path;
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    try {
      if (!await directory.exists()) {
      await directory.create(recursive: true);
    }else{
      await downloadService.downloadImage(url, '$path/$fileName.png');
    }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    finally{
      Fluttertoast.showToast(msg: 'Successfully downloaded: $path/$fileName.png');
    }
    isDownloading = false;
  }

  @action
  void scrollListener() {
    if (scrollController.position.maxScrollExtent ==
            scrollController.position.pixels &&
        textEditingController.text.toString().isEmpty) {
      page++;
      fetchPhotos(page);
    }
    if (scrollController.position.maxScrollExtent ==
            scrollController.position.pixels &&
        textEditingController.text.toString().isNotEmpty) {
      searchPage++;
      searchPhotos(searchQuery, searchPage);
    }
  }
}
