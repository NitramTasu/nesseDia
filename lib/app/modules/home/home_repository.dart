import 'package:flutter_modular/flutter_modular.dart';
import 'package:dio/dio.dart';

class HomeRepository extends Disposable {
  final searchUrl =
      'https://pt.wikipedia.org/w/api.php?action=opensearch&format=json&search=';
  final contentUrl =
      'https://pt.wikipedia.org/w/api.php?action=query&prop=revisions&rvprop=content&format=json&titles=';

  Future<String> fetchPost(Dio client) async {
    try {
      final response =
          await client.get('https://jsonplaceholder.typicode.com/posts/1');
      return response.data.toString();
    } on DioError catch (e) {
      throw (e.message);
    }
  }

  Future<List<dynamic>> searchTitle(Dio client, String search) async {
    try {
      final response = await client.get(searchUrl + search);
      return response.data;
    } on DioError catch (e) {
      throw (e.message);
    }
  }

  Future<Map<String, dynamic>> searchContent(Dio client, String title) async {
    try {
      final response = await client.get(contentUrl + title);
      return response.data;
    } on DioError catch (e) {
      throw (e.message);
    }
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
