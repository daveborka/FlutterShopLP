import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_complete_guide/models/http_exception.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;
  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.imageUrl,
      this.isFavorite});

  Future<void> toggleFavoriteStatus(String token, String userId) async {
    isFavorite = !isFavorite;
    final url = Uri.parse(
        'https://flutter-learning-ceabd-default-rtdb.europe-west1.firebasedatabase.app/userFavorites/$userId/$id.json?auth=$token');

    final response = await http.put(url,
        body: json.encode(
          isFavorite,
        ));
    if (response.statusCode > 400) {
      isFavorite = !isFavorite;
      throw HttpException('Marking as a favorite is incompleted.');
    }
    notifyListeners();
  }
}
