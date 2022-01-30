import 'dart:convert';
import 'package:flutter/foundation.dart';
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

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = Uri.parse(
      'https://flutter-learning-ceabd-default-rtdb.europe-west1.firebasedatabase.app/orders.json',
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
      ]
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
        'https://flutter-learning-ceabd-default-rtdb.europe-west1.firebasedatabase.app/orders.json');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<OrderItem> loadedOrders = [];
      extractedData.forEach((prodId, prodData) {
        loadedOrders.add(OrderItem(
          id: prodId,
          amount: prodData['amount'],
          dateTime: prodData['dateTime'],
          products: prodData['prodcuts'],
        ));
      });
      _orders = loadedOrders;
      notifyListeners();
      print(response);
    } catch (error) {
      throw error;
    }
  }
}
