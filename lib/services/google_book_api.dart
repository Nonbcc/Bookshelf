import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mybookshelf/models/google_book.dart';

class FetchGoogleBook {
  static Future<List<GoogleBook>> getBookList(String query) async {
    query = query.replaceAll(' ', '+');
    String fetchUrl =
        'https://www.googleapis.com/books/v1/volumes?q=$query&maxResults=10';

    final url = Uri.parse(fetchUrl);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final utf8Response = utf8.decode(response.bodyBytes);
      final data = json.decode(utf8Response)['items'];
      return data.map<GoogleBook>(GoogleBook.fromJson).toList();
    } else {
      print('api error: ${response.statusCode}');
      throw Exception('Failed to load books');
    }
  }

  static Future<GoogleBook> getGoogleBookDetail(String? id) async {
    String fetchUrl = 'https://www.googleapis.com/books/v1/volumes/$id';
    final url = Uri.parse(fetchUrl);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final utf8Response = utf8.decode(response.bodyBytes);
      final data = json.decode(utf8Response);
      return GoogleBook.fromJson(data);
    } else {
      print('api error: ${response.statusCode}');
      throw Exception('Failed to load books detail');
    }
  }
}
