import 'dart:async';
import 'package:dio/dio.dart';

class DownloadService {
  final Dio dio;
  final StreamController<int> progressController =
      StreamController<int>.broadcast();

  DownloadService({required this.dio});

  Future<void> downloadImage(String url, String filePath) async {
    try {
      await dio.download(url, filePath, onReceiveProgress: (count, total) {
        int progress = ((count / total) * 100).toInt();
        progressController.add(progress);
      });
    }catch (e) {
      throw Exception('Failed to download image: $e');
    }
  }
}
