import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../providers/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  final String token;
  final String userId;
  Orders(this.token, this._orders, this.userId);
  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = Uri.parse(
      'https://flutter-learning-ceabd-default-rtdb.europe-west1.firebasedatabase.app/orders.json?auth=$token',
    );
    final now = DateTime.now();
    var jsonObject = json.encode({
      "amount": total,
      "dateTime": now.toString(),
      "products": [
        ...cartProducts.map((e) {
          return {
            "id": e.id,
            "price": e.price,
            "quantity": e.quantity,
            "title": e.title
          };
        })
      ],
      "orderedBy": userId
    });
    final response = await http.post(url, body: jsonObject);
    _orders.insert(
        0,
        OrderItem(
            id: json.decode(response.body)["name"],
            amount: total,
            products: cartProducts,
            dateTime: now));
    notifyListeners();
  }

  Future<void> fetchAndSetOrders() async {
    final url = Uri.parse(
        'https://flutter-learning-ceabd-default-rtdb.europe-west1.firebasedatabase.app/orders.json?auth=$token&orderBy="orderedBy"&equalTo="$userId"');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<OrderItem> loadedOrders = [];
      List<CartItem> items = [];
      extractedData.forEach((prodId, prodData) {
        loadedOrders.add(OrderItem(
          id: prodId,
          amount: prodData['amount'],
          dateTime: DateTime.parse(prodData['dateTime']),
          products: (prodData["products"] as List<dynamic>)
              .map((e) => CartItem(
                  id: e["id"],
                  title: e["title"],
                  quantity: e["quantity"],
                  price: e["price"]))
              .toList(),
        ));
      });
      _orders = loadedOrders.reversed.toList();
      notifyListeners();
      print(response);
    } catch (error) {
      throw error;
    }
  }

  List<CartItem> getCartItemsFromDb(Map<String, dynamic> map) {
    List<CartItem> items = [];
    map.forEach((key, value) => items.add(CartItem(
        id: value["id"],
        title: value["title"],
        quantity: value["quantity"],
        price: double.parse(value["price"]))));
    return items;
  }
}
