import 'package:flutter_flow_app/model/image_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UnsplashApiService {
  static const String _baseUrl = 'https://api.unsplash.com';
  static const String _clientId = 'FbTK3M9XCwS7yYlAburrD6UFpJQ06OCmKoqhuaz-xHw';

  Future<List<ImageModel>> fetchImages({int page = 1, int perPage = 10}) async {
    final response = await http.get(Uri.parse(
        '$_baseUrl/photos?page=$page&per_page=$perPage&client_id=$_clientId'));
    
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((json) => ImageModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load images');
    }
  }

  Future<List<ImageModel>> searchImages(String query, {int page = 1, int perPage = 10}) async {
    final response = await http.get(Uri.parse(
        '$_baseUrl/search/photos?query=$query&page=$page&per_page=$perPage&client_id=$_clientId'));
    
    if (response.statusCode == 200) {
      List data = json.decode(response.body)['results'];
      return data.map((json) => ImageModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load images');
    }
  }
}
