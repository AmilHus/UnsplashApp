import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:flutter_application_1/services/services.dart';

void main() {
  group('UnsplashService', () {
    test(
        'searchDataFromApi returns list of photo URLs if the http call completes successfully',
        () async {
      final unsplash = UnsplashService();
      unsplash.client = MockClient((request) async {
        return Response(
            jsonEncode({
              'results': [
                {
                  'urls': {'regular': 'https://images.unsplash.com/photo'}
                },
              ]
            }),
            200);
      });

      var result = await unsplash.searchDataFromApi('flowers', 1);

      expect(result[0].url.contains('https://images.unsplash.com/photo'), true);
    });

    test('searchDataFromApi handles delay correctly', () async {
      final unsplash = UnsplashService();
      unsplash.client = MockClient((request) async {
        return Response(
            jsonEncode({
              'results': [
                {
                  'urls': {'regular': 'https://images.unsplash.com/photo'}
                },
              ]
            }),
            200);
      });

      final stopwatch = Stopwatch()..start();

      await unsplash.searchDataFromApi('flowers', 1);

      stopwatch.stop();

      expect(stopwatch.elapsed.inSeconds.toStringAsFixed(2),
          const Duration(seconds: 3).inSeconds.toStringAsFixed(2));
    });
  });
}
