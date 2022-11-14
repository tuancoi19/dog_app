import 'package:dio/dio.dart';
import 'package:dog_app/config/app_config.dart';

class Api {
  Dio dio = Dio();

  Future<List<String>> fetchListBreeds() async {
    Response response = await dio.get('$baseURL/breeds/list');
    if (response.statusCode == 200) {
      Iterable data = await response.data['message'];
      List<String> result = data.map((e) => e.toString()).toList();
      return result;
    } else {
      throw Exception();
    }
  }

  Future<List<String>> fetchListImages(String name) async {
    Response response =
        await dio.get('$baseURL/breed/${name.toLowerCase()}/images');
    if (response.statusCode == 200) {
      Iterable data = await response.data['message'];
      List<String> result = data.map((e) => e.toString()).toList();
      return result;
    } else {
      throw Exception();
    }
  }
}
