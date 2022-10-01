import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/models/product.dart';


class Cart with ChangeNotifier{
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  void removeItem(String productId){
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleProduct(String productId){
    if(!_items.containsKey(productId)){
      return;
    }
    if(_items[productId]?.quantity == 1){
      removeItem(productId);
    }else{
      _items.update(productId, (existingItem) => CartItem(
        id: existingItem.id,
       name: existingItem.name, price: existingItem.price,
       productId: existingItem.productId, quantity: existingItem.quantity -1));
    }
  }

  void clear(){
    _items = {};
    notifyListeners();
  }

  int get itemsCount {
    return _items.length;
  }

  void addItem(Product product){
    if(_items.containsKey(product.id)){
      _items.update(product.id, (existingItem) => CartItem(id: existingItem.id, name: existingItem.name, price: existingItem.price, productId: existingItem.productId, quantity: existingItem.quantity + 1));
    }else{
      _items.putIfAbsent(product.id, () => CartItem(id: Random().nextDouble().toString(), name: product.name, price: product.price, productId: product.id, quantity: 1));
    }
    notifyListeners();
  }

  double get totalAmount{
    double total = 0;
    _items.forEach((key, cartItem) {
      total+= cartItem.price * cartItem.quantity;
    });
    return total;
  }
}