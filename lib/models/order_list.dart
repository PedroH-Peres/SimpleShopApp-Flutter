import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:simpleshopflutter/models/cart_item.dart';
import '../utils/constants.dart';
import 'cart.dart';
import 'order.dart';

class OrderList with ChangeNotifier {
  List<Order> _items = [];
  final String _userid;
  final String _token;

  OrderList([this._token = '',this._userid = '',this._items = const []]);

  List<Order> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadOrders() async {
    List<Order> items = [];

    final response = await http.get(
      Uri.parse('${Constants.orderBaseUrl}/$_userid.json?auth=$_token'),
    );
    if (response.body == 'null') return;
    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((orderId, orderData) {
      items.add(
        Order(
          id: orderId,
          date: DateTime.parse(orderData['date']),
          total: orderData['total'] as double,
          products: (orderData['products'] as List<dynamic>).map(
            (e) {
            return CartItem(id: e['id'], productId: e['productId'],name: e['name'] , quantity: e['quantity'], price: e['price']);
          }).toList()
        ),
      );
    });
    _items = items.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(Cart cart) async {
    final date = DateTime.now();
    final response = await http.post(
      Uri.parse('${Constants.orderBaseUrl}/$_userid.json?auth=$_token'),
      body: jsonEncode(
        {
          'total': cart.totalAmount as double,
          'date': date.toIso8601String(),
          'products': cart.items.values.map((e) => {
            'id': e.id,
            'productId': e.productId,
            'name': e.name,
            'price': e.price + 0.00,
            'quantity': e.quantity
          }).toList()
        },
      ),
    );
    final id = jsonDecode(response.body)['name'];

    _items.insert(
      0,
      Order(
        id: id,
        total: cart.totalAmount,
        date: date,
        products: cart.items.values.toList(),
      ),
    );

    notifyListeners();
  }
}
