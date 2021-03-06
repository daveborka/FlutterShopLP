import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_complete_guide/models/http_exception.dart';
import 'package:http/http.dart' as http;
import './product.dart';

class Products with ChangeNotifier {
  final String token;
  final String userId;
  Products(this.token, this.userId, this._items);
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];
  // var _showFavoritesOnyl = false;

  // void showFavoritesOnly() {
  //   _showFavoritesOnyl = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnyl = false;
  //   notifyListeners();
  // }

  List<Product> get items {
    // if (_showFavoritesOnyl) {
    //   return _items.where((element) => element.isFavorite).toList();
    // }
    return [..._items];
  }

  List<Product> get favoritesItems {
    return items.where((element) => element.isFavorite).toList();
  }

  Future<void> fetchAndSetProducts([bool filterByuser = false]) async {
    String filteringParams =
        filterByuser ? '&orderBy="creatorId"&equalTo="$userId"' : "";
    final url = Uri.parse(
        'https://flutter-learning-ceabd-default-rtdb.europe-west1.firebasedatabase.app/products.json?auth=$token$filteringParams');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProduct = [];
      if (extractedData == null) {
        return;
      }
      final favoritesUrl = Uri.parse(
          'https://flutter-learning-ceabd-default-rtdb.europe-west1.firebasedatabase.app/userFavorites/$userId.json?auth=$token');
      final favoriteResponse = await http.get(favoritesUrl);
      final favoriteData = json.decode(favoriteResponse.body);
      extractedData.forEach((prodId, prodData) {
        loadedProduct.add(Product(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          imageUrl: prodData['imageUrl'],
          isFavorite:
              favoriteData == null ? false : favoriteData[prodId] ?? false,
        ));
      });
      _items = loadedProduct;
      notifyListeners();
      print(response);
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProduct(Product value) async {
    final url = Uri.parse(
        'https://flutter-learning-ceabd-default-rtdb.europe-west1.firebasedatabase.app/products.json?auth=$token');
    try {
      final response = await http.post(url,
          body: json.encode(
            {
              'title': value.title,
              'description': value.description,
              'price': value.price,
              'imageUrl': value.imageUrl,
              'creatorId': userId,
            },
          ));
      Product product = Product(
          id: json.decode(response.body)['name'],
          title: value.title,
          description: value.description,
          price: value.price,
          imageUrl: value.imageUrl);
      _items.add(product);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final url = Uri.parse(
        'https://flutter-learning-ceabd-default-rtdb.europe-west1.firebasedatabase.app/products/${id}.json?auth=$token');
    final prodIndex = items.indexWhere((element) => element.id == id);
    if (prodIndex >= 0) {
      try {
        await http.patch(url,
            body: json.encode({
              'title': newProduct.title,
              'description': newProduct.description,
              'price': newProduct.price,
              'imageUrl': newProduct.imageUrl
            }));
        _items[prodIndex] = newProduct;
        notifyListeners();
      } catch (error) {
        throw error;
      }
    }
  }

  Future<void> deleteProduct(String id) async {
    final url = Uri.parse(
        'https://flutter-learning-ceabd-default-rtdb.europe-west1.firebasedatabase.app/products/$id.json?auth=$token');
    final existingProductIndex =
        _items.indexWhere((element) => element.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);

    await http.delete(url).then((response) {
      if (response.statusCode >= 400) {
        throw HttpException('Could not delete product');
      }
    }).catchError((error) {
      _items.insert(existingProductIndex, existingProduct);
      throw error;
    });
    notifyListeners();
  }

  Product findById(String id) =>
      _items.firstWhere((product) => product.id == id);
}
