import 'dart:convert';
import 'package:flutter/foundation.dart'; //this is used to use @required in constructor.
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  }); //{} this curly braces are used to named arguments in cosntructor

  void _setFavorite(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String token, String userId) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite; //it convert into true to false and vice versa.
    notifyListeners(); //notify Listener is used as like setstate
    final url =
        "https://myshop-db798-default-rtdb.firebaseio.com/userFavorites/$userId/$id.json?auth=$token";
    try {
      final response = await http.put(
          Uri.parse(
            url,
          ),
          body: json.encode(
            isFavorite,
          ));
      if (response.statusCode >= 400) {
        _setFavorite(oldStatus);
      }
    } catch (error) {
      _setFavorite(oldStatus);
    }
  }
}
