import 'package:dio/dio.dart';
import 'package:flutter_application_1/services/services.dart';
import 'package:test/test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'dart:io';

void main() {
  test('downloads a file', () async {
    final dio = Dio();
    final dioAdapter = DioAdapter(dio: dio);

    dio.httpClientAdapter = dioAdapter;

    const path = 'http://example.com/file.txt';
    const savePath = 'test/temp/file.txt'; // Use a writable path

    dioAdapter.onGet(
      path,
      (request) {
        // Mock a file content
        const content = 'Mock file content';
        request.reply(200, content, headers: {
          HttpHeaders.contentTypeHeader: ['text/plain'],
        });
      },
    );

    final downloadService = DownloadService(dio: dio);

    // Ensure the directory exists
    final dir = Directory('test/temp');
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }

    await downloadService.downloadImage(path, savePath);

    final file = File(savePath);
    expect(await file.exists(), true);
    expect(await file.readAsString(), 'Mock file content'); // Verify the content
  });
}
