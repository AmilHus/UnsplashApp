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
    const savePath = '/path/to/save/file.txt';

    dioAdapter.onGet(
      path,
      (request) => request.reply(200, {'message': 'Successfully mocked GET!'}),
    );

    final downloadService = DownloadService(dio: dio);

    await downloadService.downloadImage(path, savePath);

    final file = File(savePath);
    expect(await file.exists(), true);
  });
}
