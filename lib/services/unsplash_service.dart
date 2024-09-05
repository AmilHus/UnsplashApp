import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/image_model.dart';

class UnsplashService {
  http.Client client = http.Client();
  final String _accessKey = '43EkVmFwu78fBz-zOMQKuIg_GvfVcHkvy9GT-ALvbAw';

  Future<List<ImageModel>> fetchDataFromApi(int page) async {
    try {
      final response = await client
          .get(
            Uri.parse(
                'https://api.unsplash.com/photos/?page=$page&per_page=30&client_id=$_accessKey'),
          )
          .timeout(const Duration(seconds: 10));

      final data = jsonDecode(response.body) as List;
      return data.map((json) => ImageModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load images: $e');
    }
  }

  Future<List<ImageModel>> searchDataFromApi(String query, int searchPage) async {
  try {
    await Future.delayed(const Duration(seconds: 3));

    final response = await client
        .get(
          Uri.parse(
              'https://api.unsplash.com/search/photos?page=$searchPage&per_page=30&query=$query&client_id=$_accessKey'),
        )
        .timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['results'] != null && data['results'] is List) {
        final results = data['results'] as List;

        return results.map((json) => ImageModel.fromJson(json)).toList();
      } else {
        throw Exception('Unexpected response format: results is not a list.');
      }
    } else {
      throw Exception('Failed to search images: ${response.statusCode} ${response.reasonPhrase}');
    }
  } catch (e) {
    throw Exception('Failed to search images: $e');
  }
}

}
